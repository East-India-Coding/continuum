import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/llm_service.dart';

class ConversationEndpoint extends Endpoint {
  final double distanceThreshold = 0.4;

  /// Answers questions using stored knowledge graph and speaker perspective
  Stream<String> askQuestion(
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
    final questionEmbedding = await llmService.generateEmbedding(question);

    final nodes = await GraphNode.db.find(
      session,
      where: (n) =>
          n.userId.equals(userId) &
          n.primarySpeakerId.equals(speaker.id!) &
          (n.embedding.distanceCosine(questionEmbedding) < distanceThreshold),
      limit: 5,
    );

    final answerStream = llmService.generateConversationalAnswer(
      question,
      speaker.name,
      nodes,
    );

    await for (var chunk in answerStream) {
      yield chunk;
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
}
