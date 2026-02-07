import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/llm_service.dart';
import '../services/knowledge_curator_tools.dart';
import '../services/llm_prompts.dart';

class ConversationEndpoint extends Endpoint {
  final double distanceThreshold = 0.4;

  /// Answers questions using stored knowledge graph and speaker perspective
  Stream<AgentResponse> askQuestion(
    Session session,
    String question,
    Speaker speaker, {
    bool isDemo = false,
  }) async* {
    String? userId;
    if (isDemo) {
      userId = session.passwords['demoUserId'];
      if (userId == null) {
        throw Exception('Demo user not configured');
      }
    } else {
      userId = session.authenticated?.userIdentifier;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
    }

    final llmService = LLMService();
    final toolsWrapper = KnowledgeCuratorTools(
      session,
      userId,
      llmService: llmService,
      isDemo: isDemo,
    );

    final agent = llmService.createCuratorAgent(
      tools: toolsWrapper.conversationTools,
    );

    final prompt = LLMPrompts.conversationalAnswerPrompt(
      question,
      speaker.name,
    );

    try {
      final stream = agent.sendStream(prompt);
      await for (final chunk in stream) {
        if ((chunk.thinking != null && chunk.thinking!.isNotEmpty) ||
            (chunk.output.isNotEmpty)) {
          yield AgentResponse(
            thinking: chunk.thinking,
            result: chunk.output.isNotEmpty ? chunk.output : null,
          );
        }
      }
    } catch (e) {
      session.log('Error in askQuestion: $e', level: LogLevel.error);
      yield AgentResponse(result: 'I encountered an error: $e');
    }
  }

  Future<List<Speaker>> listSpeakers(
    Session session, {
    bool isDemo = false,
  }) async {
    String? userId;
    if (isDemo) {
      userId = session.passwords['demoUserId'];
      if (userId == null) {
        throw Exception('Demo user not configured');
      }
    } else {
      userId = session.authenticated?.userIdentifier;
      if (userId == null) {
        session.log(
          'listSpeakers: User not authenticated',
          level: LogLevel.warning,
        );
        throw Exception('User not authenticated');
      }
    }

    final speakers = await Speaker.db.find(
      session,
      where: (p) => p.userId.equals(userId),
      orderBy: (p) => p.createdAt,
      orderDescending: true,
    );

    session.log(
      'listSpeakers: Found ${speakers.length} speakers for user $userId',
    );
    return speakers;
  }

  Future<List<String>> getRecommendedQuestions(
    Session session,
    Speaker speaker,
  ) async {
    try {
      final userId = session.authenticated?.userIdentifier;
      if (userId == null) {
        session.log(
          'getRecommendedQuestions: User not authenticated',
          level: LogLevel.warning,
        );
        throw Exception('User not authenticated');
      }

      // find 3 most impactful nodes from the user
      final nodes = await GraphNode.db.find(
        session,
        where: (n) => n.primarySpeakerId.equals(speaker.id),
        orderBy: (n) => n.impactScore,
        orderDescending: true,
        limit: 3,
      );

      if (nodes.isEmpty) {
        return [];
      }

      final llmService = LLMService();

      final concepts = nodes.map((n) => '${n.label}: ${n.summary}').toList();

      return llmService.getRecommendedQuestions(session, concepts);
    } catch (e) {
      session.log(
        'Error in getRecommendedQuestions: $e',
        level: LogLevel.error,
      );
      return [];
    }
  }
}
