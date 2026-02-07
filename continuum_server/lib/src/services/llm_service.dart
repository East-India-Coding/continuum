import 'dart:io';

import 'package:continuum_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:dartantic_ai/dartantic_ai.dart';

import 'package:continuum_server/src/services/llm_prompts.dart';

class LLMService {
  late final String _geminiAPIKey;

  late final Agent _agent = _createAgent();

  LLMService()
    : _geminiAPIKey = Serverpod.instance.getPassword('geminiApiKey')!;

  /// Returns Agentic segmented transcript with speaker info and timestamps
  Future<SegmentedTranscript> getSegmentedTranscript(
    Session session,
    Podcast podcast,
    int jobId,
    File? captionsFile,
  ) async {
    try {
      final attachments = <DataPart>[];
      if (captionsFile != null) {
        final captionsBytes = await captionsFile.readAsBytes();
        session.log(
          'LLMService: Captions file read, size: ${captionsBytes.length} bytes',
        );

        attachments.add(
          DataPart(
            captionsBytes,
            mimeType: 'application/json',
          ),
        );
      }

      final result = await _agent.sendFor<SegmentedTranscript>(
        LLMPrompts.segmentedTranscriptPrompt(
          podcast.title,
          podcast.channelName,
          podcast.youtubeUrl,
        ),
        outputSchema: LLMPrompts.segmentedTranscriptSchema,
        outputFromJson: SegmentedTranscript.fromJson,
        attachments: attachments,
      );
      session.log('LLMService: Received response from Gemini');

      await captionsFile?.delete();

      return result.output;
    } catch (e) {
      session.log(
        'LLMService: Error fetching segmented transcript: $e',
        level: LogLevel.error,
      );
      rethrow;
    }
  }

  Future<Vector> generateEmbedding(String text) async {
    try {
      final embedding = await _agent.embedQuery(text);
      return Vector(embedding.embeddings);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Vector>> generateEmbeddings(List<String> texts) async {
    try {
      final futures = texts.map((text) => _agent.embedQuery(text));
      final results = await Future.wait(futures);
      return results.map((e) => Vector(e.embeddings)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Agent _createAgent() {
    Agent.environment['GEMINI_API_KEY'] = _geminiAPIKey;
    return Agent(
      'google?chat=gemini-3-flash-preview&embeddings=gemini-embedding-001',
      embeddingsModelOptions: const GoogleEmbeddingsModelOptions(
        dimensions: 768,
      ),
    );
  }

  Agent createCuratorAgent({required List<Tool> tools}) {
    Agent.environment['GEMINI_API_KEY'] = _geminiAPIKey;
    return Agent(
      'google?chat=gemini-3-flash-preview&embeddings=gemini-embedding-001',
      tools: tools,
      enableThinking: true,
      embeddingsModelOptions: const GoogleEmbeddingsModelOptions(
        dimensions: 768,
      ),
    );
  }

  Future<List<String>> getRecommendedQuestions(
    Session session,
    List<String> concepts,
  ) async {
    try {
      final prompt = LLMPrompts.recommendedQuestionsPrompt(concepts);
      final response = await _agent.sendFor<Map<String, dynamic>>(
        prompt,
        outputSchema: LLMPrompts.recommendedQuestionsSchema,
        outputFromJson: (json) => json,
      );

      final questions = List<String>.from(response.output['questions']);
      return questions;
    } catch (e) {
      session.log(
        'LLMService: Error getting recommended questions: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }
}
