
import { onDocumentCreated } from "firebase-functions/v2/firestore";
import * as admin from "firebase-admin";
import { YoutubeTranscript } from "youtube-transcript";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { geminiApiKey, cosineDistance } from "./utils";

const db = admin.firestore();

// --- Models ---

interface IngestionJob {
    podcastId: string;
    userId: string;
    status: string;
    stage: string;
    progress: number;
}

interface Podcast {
    videoId: string;
    title: string;
    channelName: string;
    youtubeUrl: string;
}

interface SegmentedTranscript {
    videoId: string;
    ideas: TranscriptIdea[];
}

interface TranscriptIdea {
    label: string;
    summary: string;
    impactScore: number;
    primarySpeaker: string;
    references: { quote: string; start: number; end: number }[];
}

// --- Prompts ---

const SEGMENTED_TRANSCRIPT_PROMPT = (title: string, channel: string, url: string) => `
You are an expert Knowledge Extraction system.

Read the attached captions file to extract atomic semantic ideas.
A semantic idea represents a single, self-contained concept.

Youtube URL: ${url}
Video Title: ${title}
Channel Name: ${channel}

Rules:
1. Extract at least 10 distinct semantic ideas from the video.
2. Each idea must include:
   - A concise label (2–6 words)
   - A detailed summary explaining the idea
   - Impact score (0-1) - How important is this idea?
   - Primary speaker - Who is the main speaker of this idea?
   - One or more timestamped references (in seconds) where the idea is discussed. Use the timestamps from the captions file to generate the references.
3. Only include references spoken by the guest(s). Do NOT include the interviewer or host. Keep only one primary speaker for each idea.
4. Speaker names must be the full, human-readable name.
5. The start and end timestamps MUST be in seconds since the beginning of the audio.
6. Do not invent ideas. Only extract ideas clearly discussed in the audio.
7. Output must be strictly in English. Do not translate the audio.
8. Output must be JSON.

Structure:
{
  "ideas": [
    {
      "label": "string",
      "summary": "string",
      "impactScore": number,
      "primarySpeaker": "string",
      "references": [{"quote": "string", "start": number, "end": number}]
    }
  ]
}
`;

// --- Services ---

async function fetchCaptions(videoId: string): Promise<string> {
    try {
        const transcriptItems = await YoutubeTranscript.fetchTranscript(videoId);
        // Convert to a simplified JSON string to save tokens/complexity, or pass full JSON
        // The prompt expects "attached captions file". We'll combine them.
        return JSON.stringify(transcriptItems.map(t => ({
            text: t.text,
            start: t.offset / 1000, // library returns ms? Check doc. Usually offset is ms? 
            // verifying standard youtube-transcript output: {text: string, duration: number, offset: number}
            end: (t.offset + t.duration) / 1000
        })));
    } catch (e) {
        console.error("Error fetching captions", e);
        throw new Error("Failed to fetch captions");
    }
}

async function updateJobStatus(jobId: string, status: string, stage: string, progress: number, errorMessage?: string) {
    await db.collection("ingestion_jobs").doc(jobId).update({
        status,
        stage,
        progress,
        errorMessage: errorMessage || null,
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        completedAt: status === 'completed' || status === 'failed' ? admin.firestore.FieldValue.serverTimestamp() : null
    });
}

// --- Main Trigger ---

export const processPodcastJob = onDocumentCreated(
    { document: "ingestion_jobs/{jobId}", secrets: [geminiApiKey], timeoutSeconds: 540 }, 
    async (event) => {
        const snap = event.data;
        if (!snap) return;

        const job = snap.data() as IngestionJob;
        const jobId = event.params.jobId;

        // Only trigger on initial creation (pending)
        if (job.status !== 'pending') return;

        console.log(`IngestionPipeline: processPodcast started for job ${jobId}`);

        try {
            await updateJobStatus(jobId, 'processing', 'Initializing ingestion', 10);

            // 1. Verify Podcast
            const podcastRef = db.collection("podcasts").doc(job.podcastId);
            const podcastSnap = await podcastRef.get();
            if (!podcastSnap.exists) {
                throw new Error("Podcast not found");
            }
            const podcast = podcastSnap.data() as Podcast;

            await updateJobStatus(jobId, 'processing', 'Podcast verified', 15);

            // 2. Check Transcript Cache
            let segmentedTranscript: SegmentedTranscript | null = null;
            
            // Check if we already have a transcript for this videoId
            // Assuming "segmented_transcripts" collection
            const transcriptQuery = await db.collection("segmented_transcripts")
                .where("videoId", "==", podcast.videoId)
                .limit(1)
                .get();

            await updateJobStatus(jobId, 'processing', 'Checking transcript cache', 20);

            if (!transcriptQuery.empty) {
                console.log(`IngestionPipeline: Found existing transcript for video ${podcast.videoId}`);
                segmentedTranscript = transcriptQuery.docs[0].data() as SegmentedTranscript;
            } else {
                console.log(`IngestionPipeline: Generating transcript for ${podcast.videoId}`);
                await updateJobStatus(jobId, 'processing', 'Generating transcript', 25);

                // Fetch Captions
                const captions = await fetchCaptions(podcast.videoId);
                
                await updateJobStatus(jobId, 'processing', 'AI Agent processing', 45);

                // Generate with Gemini
                const genAI = new GoogleGenerativeAI(geminiApiKey.value());
                const model = genAI.getGenerativeModel({ 
                    model: "gemini-1.5-flash", 
                    generationConfig: { responseMimeType: "application/json" } 
                });

                const prompt = SEGMENTED_TRANSCRIPT_PROMPT(podcast.title, podcast.channelName, podcast.youtubeUrl);
                
                // We might override the timeout if the video is long, but Function timeout is max 540s.
                // Pass captions as a text part (if fits context) or file. 
                // Gemini 1.5 Flash has 1M context, textual captions should fit easily.
                const result = await model.generateContent([prompt, captions]);
                const responseText = result.response.text();
                const jsonResponse = JSON.parse(responseText);

                if (!jsonResponse.ideas) {
                    throw new Error("Invalid LLM response: missing ideas");
                }

                segmentedTranscript = {
                    videoId: podcast.videoId,
                    ideas: jsonResponse.ideas
                };

                await updateJobStatus(jobId, 'processing', 'AI generation completed', 60);

                // Store Transcript
                await db.collection("segmented_transcripts").add(segmentedTranscript);
                await updateJobStatus(jobId, 'processing', 'Transcript stored', 70);
            }

            // 3. Build Knowledge Graph
            await updateJobStatus(jobId, 'processing', 'Building knowledge graph', 80);
            
            if (segmentedTranscript && segmentedTranscript.ideas.length > 0) {
                await processTranscriptIdeas(job.userId, job.podcastId, podcast.videoId, segmentedTranscript.ideas);
            } else {
                throw new Error("No ideas found in transcript");
            }

            // 4. Complete
            await podcastRef.update({ graphExists: true });
            await updateJobStatus(jobId, 'completed', 'Completed', 100);

        } catch (e: any) {
            console.error(`IngestionPipeline: Error processing podcast: ${e}`);
            await updateJobStatus(jobId, 'failed', 'Error', 0, e.message || e.toString());
        }
    }
);

async function processTranscriptIdeas(
    userId: string, 
    podcastId: string, 
    videoId: string, 
    ideas: TranscriptIdea[]
) {
    const genAI = new GoogleGenerativeAI(geminiApiKey.value());
    const embedModel = genAI.getGenerativeModel({ model: "text-embedding-004" });

    // 1. Generate Embeddings (batching if necessary, but 1.5 Flash supports list? Not embedContent. embedContent takes string)
    // batchEmbedContents is available
    const embeddingTexts = ideas.map(idea => `${idea.label}: ${idea.summary}`);
    
    // Google GenAI Node SDK batchEmbedContents:
    // model.batchEmbedContents({ requests: [...] })
    const batchRequests = embeddingTexts.map(text => ({ content: { parts: [{ text }] }, taskType: "RETRIEVAL_DOCUMENT" }));
    
    // Note: Verify batch limits. Typically 100?
    // We'll assume < 100 ideas for now or chunk if needed.
    let embeddings: number[][] = [];
    
    // Simple trunking 
    const chunkSize = 20; 
    for (let i = 0; i < batchRequests.length; i += chunkSize) {
        const chunk = batchRequests.slice(i, i + chunkSize);
         // @ts-ignore: types might mismatch slightly depending on version, casting to any if needed
        const batchResult = await embedModel.batchEmbedContents({ requests: chunk as any });
        embeddings.push(...batchResult.embeddings.map(e => e.values));
    }

    // 2. Pre-process speakers
    const uniqueSpeakers = new Set(ideas.map(e => e.primarySpeaker));
    const speakerCache: Record<string, string> = {}; // Name -> ID

    for (const speakerName of uniqueSpeakers) {
        speakerCache[speakerName] = await mergeOrCreateSpeaker(userId, speakerName);
    }

    // 3. Create Nodes and Edges
    let nodesCreated = 0;
    
    for (let i = 0; i < ideas.length; i++) {
        const idea = ideas[i];
        const embedding = embeddings[i];
        const speakerId = speakerCache[idea.primarySpeaker];

        // Create Node
        const nodeRef = await db.collection("graph_nodes").add({
            userId,
            videoId,
            label: idea.label,
            impactScore: idea.impactScore,
            summary: idea.summary,
            primarySpeakerId: speakerId,
            references: idea.references, // Store as objects
            embedding: embedding, // Store vector
            isBookmarked: false,
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        });
        const nodeId = nodeRef.id;
        nodesCreated++;

        // Link similar topics
        // Fetch candidates for linking - simple exact match filtering or expensive full scan?
        // In Firestore, we can't search by vector distance natively without an extension.
        // Serverpod logic: fetched ALL nodes for user and calculated distance in code?
        // Or "GraphNode.db.find(where ... distance < threshold)" -> Serverpod does this in DB if PGVector? 
        // Logic in Dart file:
        // where: (n) => n.userId.equals(userId) & (n.embedding.distanceCosine(ideaEmbedding) < linkThreshold)
        
        // Emulating this in Firestore without vector search extension is HARD/Expensive for large datasets.
        // We will fetch "recent" or "same podcast" nodes? 
        // Or fetch all user nodes? If user has 1000 nodes, it's 1000 reads.
        // For MVP/Demo scale, fetching all user nodes (excluding current) content headers (id, embedding) might be okay.
        
        const candidateSnap = await db.collection("graph_nodes")
            .where("userId", "==", userId)
            .select("embedding") // Only fetch embedding
            .get();
            
        const similarNodes: string[] = [];
        const linkThreshold = 0.35;

        candidateSnap.forEach(doc => {
            if (doc.id === nodeId) return;
            const data = doc.data();
            if (data.embedding) {
                const dist = cosineDistance(embedding, data.embedding);
                if (dist < linkThreshold) {
                    similarNodes.push(doc.id);
                }
            }
        });
        
        // Sort by distance if we want strictly the logic: "link... ordering by distance"
        // The Dart code loops through sorted similarNodes and adds edge with decaying weight.
        // We will just add edges for found similar nodes.
        
        // Need to sort similarNodes by distance first to apply the rank-based weight
        // Re-calculating distance for sort
        const sortedCandidates = similarNodes.map(id => {
            const data = candidateSnap.docs.find(d => d.id === id)!.data();
            return { id, distance: cosineDistance(embedding, data.embedding) };
        }).sort((a, b) => a.distance - b.distance);

        let rank = 0;
        for (const candidate of sortedCandidates) {
            const weight = Math.max(0.4, 1.0 - (rank * 0.1));
            rank++;

            await db.collection("graph_edges").add({
                userId,
                sourceNodeId: nodeId,
                targetNodeId: candidate.id,
                weight
            });
        }
    }
    
    return nodesCreated;
}

async function mergeOrCreateSpeaker(userId: string, speakerName: string): Promise<string> {
    const normalizedName = speakerName.toLowerCase().replace(/\s/g, '').trim();
    
    const snapshot = await db.collection("speakers")
        .where("userId", "==", userId)
        .where("normalizedName", "==", normalizedName)
        .limit(1)
        .get();
        
    if (!snapshot.empty) {
        const doc = snapshot.docs[0];
        const data = doc.data();
        await doc.ref.update({
            detectedCount: (data.detectedCount || 0) + 1,
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });
        return doc.id;
    }

    const docRef = await db.collection("speakers").add({
        userId,
        name: speakerName,
        normalizedName,
        detectedCount: 1,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    return docRef.id;
}
