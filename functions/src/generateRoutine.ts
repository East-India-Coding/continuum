/* eslint-disable max-len */
import { onRequest } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import { GoogleGenerativeAI } from "@google/generative-ai";
import { defineSecret } from "firebase-functions/params";

const geminiApiKey = defineSecret("GEMINI_API_KEY");

// Utility functions for common validations
const validateApiKey = (apiKey: string, response: any): boolean => {
  if (!apiKey) {
    logger.error("⚠️ Gemini API Key is not set");
    response.sendStatus(400);
    return false;
  }
  return true;
};

const validateRequestMethod = (method: string, response: any): boolean => {
  if (method !== "POST") {
    response
      .status(405)
      .json({ error: "Method Not Allowed. Use POST request." });
    return false;
  }
  return true;
};

const validateRequestBody = (
  body: any,
  response: any
): { isValid: boolean; prompt?: string } => {
  const { prompt } = body;
  if (!prompt || typeof prompt !== "string") {
    response.status(400).json({
      error: "Invalid request body. 'prompt' is required and must be a string.",
    });
    return { isValid: false };
  }
  return { isValid: true, prompt };
};

// Shared constants
const GENERATIVE_MODEL = "gemini-1.5-flash";
const GENERATION_CONFIG = { responseMimeType: "application/json" };

// Prompt templates
const PROMPTS = {
  generateRoutine:
    "You are a professional life coach specializing in creating actionable weekly plans to help people achieve their ideal lives. You provide highly specific, measurable, and tailored advice, avoiding generic suggestions. Based on the details provided, create a weekly timetable in JSON format that includes clear tasks, categorized by their relevance to the person's goals, with realistic time frames and durations.",
  rephraseGoals:
    "Transform the following array of goals as a statement of fact in first person in present tense, implying the person has already achieved them. Ensure the sentences are grammatically correct and free of spelling errors.",
};

// Output format templates
const OUTPUT_FORMATS = {
  generateRoutine: `This should be the output format. The startTime and endTime must be in military time format. The emoji field should always contain only one emoji:
{
  "weeklyTimetable": {
    "monday": [
      {
        "title": "task title",
        "category": "Category 1",
        "emoji": "✨",
        "startTime": "2000",
        "endTime": "2045"
      }
    ],
    "tuesday": [
      {
        "title": "task title",
        "category": "Category 1",
        "emoji": "💪",
        "startTime": "1200",
        "endTime": "1300"
      }
    ]
  }
}`,
  rephraseGoals: `This should be the output format: {
  "goals" : [
    "goal #1",
    "goal #2",
    "goal #3"
  ]
}`,
};

// Helper function for generating content
const generateContent = async (
  apiKey: string,
  startPrompt: string,
  prompt: string,
  outputFormat: string
): Promise<string> => {
  const genAI = new GoogleGenerativeAI(apiKey);
  const model = genAI.getGenerativeModel({
    model: GENERATIVE_MODEL,
    generationConfig: GENERATION_CONFIG,
  });
  const result = await model.generateContent([
    `${startPrompt} ${prompt} ${outputFormat}`,
  ]);
  return result.response.text();
};

// Handlers
export const generateRoutine = onRequest(
  { secrets: [geminiApiKey] },
  async (request, response) => {
    const apiKey = geminiApiKey.value();
    if (
      !validateApiKey(apiKey, response) ||
      !validateRequestMethod(request.method, response)
    ) {
      return;
    }

    const { isValid, prompt } = validateRequestBody(request.body, response);
    if (!isValid || !prompt) {
      return;
    }

    try {
      const result = await generateContent(
        apiKey,
        PROMPTS.generateRoutine,
        prompt,
        OUTPUT_FORMATS.generateRoutine
      );
      logger.info(`Generated content: ${result}`, { structuredData: true });
      response.status(200).json({ data: result });
    } catch (error) {
      logger.error("Error generating content", error);
      response.status(500).json({
        error: "Failed to generate content. Please try again later.",
      });
    }
  }
);

export const rephraseGoals = onRequest(
  { secrets: [geminiApiKey] },
  async (request, response) => {
    const apiKey = geminiApiKey.value();
    if (
      !validateApiKey(apiKey, response) ||
      !validateRequestMethod(request.method, response)
    ) {
      return;
    }

    const { isValid, prompt } = validateRequestBody(request.body, response);
    if (!isValid || !prompt) {
      return;
    }

    try {
      const result = await generateContent(
        apiKey,
        PROMPTS.rephraseGoals,
        prompt,
        OUTPUT_FORMATS.rephraseGoals
      );
      logger.info(`Generated content: ${result}`, { structuredData: true });
      response.status(200).json({ data: result });
    } catch (error) {
      logger.error("Error generating content", error);
      response.status(500).json({
        error: "Failed to generate content. Please try again later.",
      });
    }
  }
);