import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'llm_service.dart';

class GraphService {
  final linkThreshold = 0.35;

  Future<int> mergeOrCreateSpeaker(
    Session session,
    String userId,
    String speakerName,
  ) async {
    final normalizedName = speakerName.toLowerCase().replaceAll(' ', '').trim();

    final existingSpeaker = await Speaker.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.normalizedName.equals(normalizedName),
    );

    if (existingSpeaker != null && existingSpeaker.id != null) {
      session.log(
        'GraphService: found existing speaker: $speakerName (id: ${existingSpeaker.id})',
      );
      await Speaker.db.updateRow(
        session,
        existingSpeaker.copyWith(
          detectedCount: existingSpeaker.detectedCount + 1,
          updatedAt: DateTime.now(),
        ),
      );
      return existingSpeaker.id!;
    }

    session.log('GraphService: Creating new speaker: $speakerName');
    final speaker = Speaker(
      userId: userId,
      name: speakerName,
      normalizedName: normalizedName,
      detectedCount: 1,
    );

    final insertedSpeaker = await Speaker.db.insertRow(session, speaker);
    return insertedSpeaker.id!;
  }

  /// Creates nodes and links for a segmented transcript
  /// Returns the number of nodes created
  Future<int> processTranscriptIdeas(
    Session session,
    String userId,
    int podcastId,
    String videoId,
    List<TranscriptTopic> ideas,
  ) async {
    session.log(
      'GraphService: processTranscriptIdeas started with ${ideas.length} ideas',
    );
    final llmService = LLMService();
    int nodesCreated = 0;

    // 1. Generate embeddings in parallel
    final embeddingTexts = ideas
        .map((idea) => '${idea.label}: ${idea.summary}')
        .toList();
    final embeddings = await llmService.generateEmbeddings(embeddingTexts);

    // 2. Pre-process speakers (Cache IDs)
    final speakerCache = <String, int>{};
    final uniqueSpeakers = ideas.map((e) => e.primarySpeaker).toSet();

    for (final speakerName in uniqueSpeakers) {
      speakerCache[speakerName] = await mergeOrCreateSpeaker(
        session,
        userId,
        speakerName,
      );
    }

    // 3. Create Nodes and Links
    for (var i = 0; i < ideas.length; i++) {
      final idea = ideas[i];
      final ideaEmbedding = embeddings[i];

      final speakerId = speakerCache[idea.primarySpeaker]!;

      final ideaNode = await GraphNode.db.insertRow(
        session,
        GraphNode(
          userId: userId,
          videoId: videoId,
          label: idea.label,
          impactScore: idea.impactScore,
          summary: idea.summary,
          primarySpeakerId: speakerId,
          references: idea.references
              .map(
                (r) => QuoteReference(
                  startTime: r.start,
                  endTime: r.end,
                  verbatimQuote: r.quote,
                ),
              )
              .toList(),
          embedding: ideaEmbedding,
        ),
      );
      nodesCreated++;

      // Link similar topics based on distanceCosine (user specific)
      final similarNodes = await GraphNode.db.find(
        session,
        where: (n) =>
            n.userId.equals(userId) &
            (n.embedding.distanceCosine(ideaEmbedding) < linkThreshold),
        orderBy: (n) => n.embedding.distanceCosine(ideaEmbedding),
      );
      session.log(
        'GraphService: processTranscriptIdeas found ${similarNodes.length} similar nodes for idea ${idea.label}',
      );

      var rank = 0;
      for (final similarNode in similarNodes) {
        if (similarNode.id == ideaNode.id) continue;

        final weight = (1.0 - (rank * 0.1)).clamp(0.4, 1.0);
        rank++;

        await GraphEdge.db.insertRow(
          session,
          GraphEdge(
            userId: userId,
            sourceNodeId: ideaNode.id!,
            targetNodeId: similarNode.id!,
            weight: weight,
          ),
        );
      }
    }

    session.log(
      'GraphService: processTranscriptIdeas completed. Nodes created: $nodesCreated',
    );
    return nodesCreated;
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
