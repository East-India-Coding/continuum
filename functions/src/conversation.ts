
import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { getUserId, cosineDistance, geminiApiKey } from "./utils";
import { GoogleGenerativeAI } from "@google/generative-ai";

const db = admin.firestore();

interface GraphNode {
    id: string; // Document ID
    userId: string;
    primarySpeakerId: string;
    embedding: number[];
    label: string;
    videoId: string;
    summary: string;
    references: any[]; // Assuming generic structure or we can define it strictly
    impactScore: number;
    isBookmarked: boolean;
}

interface Speaker {
    id: string; // Document ID
    userId: string;
    name: string;
    createdAt: any;
}

const DISTANCE_THRESHOLD = 0.4;
const MODEL_NAME = "gemini-1.5-flash";
const EMBEDDING_MODEL = "text-embedding-004"; // or embedding-001

export const askQuestion = onCall({ secrets: [geminiApiKey] }, async (request) => {
    const userId = getUserId(request);
    const { question, speakerId, isDemo } = request.data;
    const speakerName = request.data.speakerName; // Assuming passed or we fetch it.

    if (!question || !speakerId || !speakerName) {
        throw new HttpsError('invalid-argument', 'Missing question, speakerId, or speakerName');
    }

    // Initialize Gemini
    const genAI = new GoogleGenerativeAI(geminiApiKey.value());
    const embedModel = genAI.getGenerativeModel({ model: EMBEDDING_MODEL });
    
    // Generate embedding for question
    const embedResult = await embedModel.embedContent(question);
    const questionEmbedding = embedResult.embedding.values;

    // Fetch candidate nodes
    // Ideally we would use Vector Search. Here we fetch likely candidates.
    // We assume the user doesn't have too many nodes for a specific speaker.
    const nodesRef = db.collection("graph_nodes");
    const snapshot = await nodesRef
        .where("userId", "==", userId)
        .where("primarySpeakerId", "==", speakerId)
        .get();

    const candidates: { node: GraphNode, distance: number }[] = [];
    
    snapshot.forEach(doc => {
        const data = doc.data() as GraphNode;
        // Ensure embedding exists and is valid
        if (data.embedding && Array.isArray(data.embedding)) {
            const dist = cosineDistance(questionEmbedding, data.embedding);
            if (dist < DISTANCE_THRESHOLD) {
                candidates.push({ node: { ...data, id: doc.id }, distance: dist });
            }
        }
    });

    // Sort by distance (ascending) and take top 5
    candidates.sort((a, b) => a.distance - b.distance);
    const topNodes = candidates.slice(0, 5).map(c => c.node);

    if (topNodes.length === 0) {
        return `[${speakerName}] I don’t have enough context from the podcast to answer this. Please ask a question related to the podcast or provide more details.`;
    }

    // Construct Context
    const contextEntries = topNodes.map(node => ({
        label: node.label,
        summary: node.summary,
        references: node.references.map(r => JSON.stringify(r)), // Stringify references
        videoId: node.videoId
    }));
    
    const contextText = JSON.stringify(contextEntries, null, 2);

    // Build Prompt
    const systemPromptMessage = 'You are a podcast speaker answering questions based on the provided context.';
    const prompt = `
You are answering a question as if you were ${speakerName} from a podcast.

Question: "${question}"

Context from the podcast:
${contextText}

Answer the question using ONLY the information provided in the context. 
Maintain the tone and perspective of ${speakerName}.
Do not make up information not present in the context.
If the context doesn't contain enough information, say so clearly, and send no references.
Compulsorily include the &t=start time parameter to the youtube link.

Format your response as follows:
[${speakerName}] [Summarized answer here - don't use the verbatim quote here]

References: "verbatimQuote" <youtubeLink>

Example:
[Andrew Huberman] Dopamine is actually about craving, not just pleasure. It drives us to seek things out.

References: "Dopamine is the currency of craving." <https://youtube.com/watch?v=videoId&t=120>
`;

    // Generate Answer
    const chatModel = genAI.getGenerativeModel({ 
        model: MODEL_NAME,
        systemInstruction: systemPromptMessage
    });

    const result = await chatModel.generateContent(prompt);
    return result.response.text();
});

export const listSpeakers = onCall(async (request) => {
    const userId = getUserId(request);
    
    const speakersRef = db.collection("speakers");
    const snapshot = await speakersRef
        .where("userId", "==", userId)
        .orderBy("createdAt", "desc")
        .get();
        
    const speakers = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    return speakers;
});
