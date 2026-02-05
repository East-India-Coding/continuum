import 'package:continuum_server/src/generated/protocol.dart';
import 'package:continuum_server/src/services/knowledge_curator_tools.dart';
import 'package:continuum_server/src/services/llm_prompts.dart';
import 'package:serverpod/serverpod.dart';
import 'llm_service.dart';

class GraphService {
  /// Creates nodes and links for a segmented transcript using an Agentic loop
  /// Returns the number of nodes created (approximate)
  Future<int> processTranscriptIdeas(
    Session session,
    String userId,
    int podcastId,
    String videoId,
    List<TranscriptTopic> ideas, {
    Function(String, int)? onProgress,
  }) async {
    session.log(
      'GraphService: processTranscriptIdeas started with ${ideas.length} ideas (Agentic)',
    );
    final llmService = LLMService();

    // 1. Initialize Tools
    final toolsWrapper = KnowledgeCuratorTools(
      session,
      userId,
      podcastId: podcastId,
      videoId: videoId,
    );
    final tools = toolsWrapper.allTools;

    // 2. Create Agent
    final agent = llmService.createCuratorAgent(tools: tools);
    int nodesProcessed = 0;

    // 3. Pre-calculate embeddings to pass to the agent
    if (onProgress != null) onProgress('Generating embeddings...', 0);
    final embeddingTexts = ideas
        .map((idea) => '${idea.label}: ${idea.summary}')
        .toList();
    final embeddings = await llmService.generateEmbeddings(embeddingTexts);

    for (var i = 0; i < ideas.length; i++) {
      final idea = ideas[i];
      final embeddingVector = embeddings[i];

      // Use internal registry to avoid passing vector string
      final embeddingId = 'emb_$i';
      toolsWrapper.registerEmbedding(embeddingId, embeddingVector);

      if (onProgress != null) {
        onProgress('Curating idea ${i + 1}/${ideas.length}: ${idea.label}', i);
      }

      final referencesJson = idea.references
          .map(
            (r) => {
              'start': r.start,
              'end': r.end,
              'quote': r.quote,
            },
          )
          .toString();

      final prompt = LLMPrompts.knowledgeCuratorPrompt(
        idea.label,
        idea.summary,
        idea.impactScore,
        idea.primarySpeaker,
        referencesJson,
        embeddingId,
      );

      try {
        final result = agent.sendStream(prompt);

        await for (final chunk in result) {
          if (chunk.thinking != null) {
            onProgress?.call(chunk.thinking!, i);
          }
        }

        nodesProcessed++;
      } catch (e) {
        session.log(
          'GraphService: Error processing idea ${idea.label}: $e',
          level: LogLevel.error,
        );
      }
    }

    session.log(
      'GraphService: processTranscriptIdeas completed. Processed: $nodesProcessed ideas',
    );
    return nodesProcessed;
  }

  Future<void> bookmarkNode(
    Session session,
    int nodeId,
    bool isBookmarked,
  ) async {
    final node = await GraphNode.db.findById(session, nodeId);
    if (node != null) {
      await GraphNode.db.updateRow(
        session,
        node.copyWith(isBookmarked: isBookmarked),
      );
    }
  }

  Future<List<GraphNode>> getBookmarkedNodes(
    Session session,
    String userId,
  ) async {
    return await GraphNode.db.find(
      session,
      where: (n) => n.userId.equals(userId) & n.isBookmarked.equals(true),
    );
  }
}
