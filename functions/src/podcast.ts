
import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";
import { getUserId } from "./utils";

const db = admin.firestore();

interface Podcast {
    id: string; // Document ID
    userId: string;
    allowedUsers?: string[]; // Serverpod had userId, assuming strict ownership
    youtubeUrl: string;
    videoId: string;
    title: string;
    channelName: string;
    thumbnailUrl: string;
    graphExists: boolean;
    createdAt: any;
}

interface IngestionJob {
    id: string; // Document ID
    podcastId: string;
    userId: string;
    status: 'pending' | 'processing' | 'completed' | 'failed';
    stage: string;
    progress: number;
    createdAt: any;
}

// Utility to extract Video ID
function extractVideoId(url: string): string | null {
    const regExp = /^.*(youtu\.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
    const match = url.match(regExp);
    if (match && match[2].length === 11) {
        return match[2];
    }
    return null;
}

export const ingestPodcast = onCall(async (request) => {
    const userId = getUserId(request);
    const { youtubeUrl } = request.data;
    
    if (!youtubeUrl) throw new HttpsError('invalid-argument', 'Missing youtubeUrl');

    const videoId = extractVideoId(youtubeUrl);
    if (!videoId) {
        throw new HttpsError('invalid-argument', 'Invalid YouTube URL');
    }

    // Check existing podcast
    const podcastQuery = await db.collection("podcasts")
        .where("userId", "==", userId)
        .where("videoId", "==", videoId)
        .get();
        
    let podcastId: string;
    let podcastTitle = "";
    let podcastChannel = "";

    if (!podcastQuery.empty) {
        const doc = podcastQuery.docs[0];
        const podcast = doc.data() as Podcast;
        podcastId = doc.id;
        podcastTitle = podcast.title;
        podcastChannel = podcast.channelName;
        
        if (podcast.graphExists) {
            throw new HttpsError('already-exists', 'Graph already exists for this podcast');
        }
    } else {
        // Fetch metadata
        try {
            const oembedUrl = `https://www.youtube.com/oembed?url=${youtubeUrl}&format=json`;
            const response = await fetch(oembedUrl);
            if (!response.ok) throw new Error("Failed to fetch metadata");
            const data = await response.json();
            
            const newPodcast = {
                userId,
                youtubeUrl,
                videoId,
                title: data.title,
                channelName: data.author_name,
                thumbnailUrl: data.thumbnail_url,
                graphExists: false,
                createdAt: admin.firestore.FieldValue.serverTimestamp()
            };
            
            const docRef = await db.collection("podcasts").add(newPodcast);
            podcastId = docRef.id;
            podcastTitle = data.title;
            podcastChannel = data.author_name;
        } catch (e) {
            console.error(e);
            throw new HttpsError('internal', 'Failed to fetch video metadata');
        }
    }

    // Create Job
    const jobData = {
        podcastId,
        userId,
        status: 'pending',
        stage: 'pending',
        progress: 0,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };
    
    const jobRef = await db.collection("ingestion_jobs").add(jobData);
    
    // Trigger Processing
    // In Firebase this could be a Firestore trigger on 'ingestion_jobs' creation.
    // For now we just log it. 
    // If the user wants to migrate the 'processPodcast' logic, it would likely be a separate trigger function.
    console.log(`Scheduled background processing for job: ${jobRef.id} (Podcast: ${podcastId})`);
    
    return { id: jobRef.id, ...jobData };
});

export const getJobStatus = onCall(async (request) => {
    const userId = getUserId(request);
    const { jobId } = request.data;
    
    if (!jobId) throw new HttpsError('invalid-argument', 'jobId missing');
    
    const jobRef = db.collection("ingestion_jobs").doc(jobId);
    const jobDoc = await jobRef.get();
    
    if (!jobDoc.exists) throw new HttpsError('not-found', 'Job not found');
    
    const job = jobDoc.data() as IngestionJob;
    if (job.userId !== userId) throw new HttpsError('permission-denied', 'Not your job');
    
    // This returns the current status.
    // To implement streaming updates, client should use onSnapshot on the document.
    return { id: jobId, ...job };
});

export const listPodcasts = onCall(async (request) => {
    const userId = getUserId(request);
    
    const podcastsRef = db.collection("podcasts");
    // Sorting by createdAt desc
    const snapshot = await podcastsRef
        .where("userId", "==", userId)
        .orderBy("createdAt", "desc")
        .get();
        
    return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
});
