
import { CallableRequest, HttpsError } from "firebase-functions/v2/https";
import { defineSecret } from "firebase-functions/params";

export const geminiApiKey = defineSecret("GEMINI_API_KEY");
export const demoUserId = defineSecret("DEMO_USER_ID");

export function getUserId(request: CallableRequest): string {
    if (request.data.isDemo) {
        // Since we can't easily access the secret synchronously if not passed, 
        // we normally access secrets via process.env in v1, but in v2 params 
        // they are available if declared. 
        // However, for simplicity if isDemo is true, we might need to rely on 
        // the checks inside the function. 
        // But here let's validte auth if not demo.
        // Actually, to use secret values, we need to access them inside the function handler.
        // So we will pass the demoUserId value or handle it there.
        // For this helper, we'll just check auth if not demo.
        return ""; // Caller must handle demo logic with secrets
    }
    
    if (!request.auth) {
        throw new HttpsError('unauthenticated', 'User not authenticated');
    }
    return request.auth.uid;
}

export function cosineDistance(a: number[], b: number[]): number {
    if (a.length !== b.length) throw new Error("Vectors must have same length");
    let dot = 0;
    let magA = 0;
    let magB = 0;
    for (let i = 0; i < a.length; i++) {
        dot += a[i] * b[i];
        magA += a[i] * a[i];
        magB += b[i] * b[i];
    }
    return 1 - (dot / (Math.sqrt(magA) * Math.sqrt(magB)));
}
