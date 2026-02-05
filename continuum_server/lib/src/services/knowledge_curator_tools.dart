import 'package:continuum_server/src/generated/protocol.dart';
import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:json_schema/json_schema.dart';
import 'package:serverpod/serverpod.dart' as sp;
import 'package:continuum_server/src/services/llm_service.dart';

class KnowledgeCuratorTools {
  final sp.Session session;
  final String userId;
  final int? podcastId;
  final String? videoId;
  final LLMService? llmService;

  // Registry to hold embeddings temporarily so they don't need to be passed in prompts
  final Map<String, sp.Vector> _embeddingRegistry = {};

  KnowledgeCuratorTools(
    this.session,
    this.userId, {
    this.podcastId,
    this.videoId,
    this.llmService,
  });

  void registerEmbedding(String id, sp.Vector vector) {
    _embeddingRegistry[id] = vector;
  }

  void clearEmbeddings() {
    _embeddingRegistry.clear();
  }

  List<Tool> get allTools => [
    _searchSimilarNodesTool,
    _getGraphClusterSummaryTool,
    _checkSpeakerIdentityTool,
    _createGraphNodeTool,
    _createGraphEdgeTool,
  ];

  List<Tool> get conversationTools => [
    _searchGraphTool,
    _traverseGraphTool,
    _getSpeakerContextTool,
    _detectGapsTool,
  ];

  Tool get _searchSimilarNodesTool => Tool(
    name: 'searchSimilarNodes',
    description:
        'Finds existing nodes in the knowledge graph that are semantically similar to the given vector embedding. Use this to check if a topic already exists.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'embeddingId': {
          'type': 'string',
          'description': 'The ID of the embedding vector to use for search.',
        },
        'threshold': {
          'type': 'number',
          'description':
              'Cosine distance threshold. Lower is stricter (more similar). Default around 0.35.',
        },
      },
      'required': ['embeddingId'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final embeddingId = params['embeddingId'] as String;
      final threshold = (params['threshold'] as num?)?.toDouble() ?? 0.35;

      final vector = _embeddingRegistry[embeddingId];
      if (vector == null) {
        throw Exception('Embedding ID $embeddingId not found in registry.');
      }

      final similarNodes = await GraphNode.db.find(
        session,
        where: (n) =>
            n.userId.equals(userId) &
            (n.embedding.distanceCosine(vector) < threshold),
        orderBy: (n) => n.embedding.distanceCosine(vector),
        limit: 5,
      );

      return {
        'nodes': similarNodes
            .map(
              (node) => {
                'id': node.id,
                'label': node.label,
                'summary': node.summary,
              },
            )
            .toList(),
      };
    },
  );

  Tool get _getGraphClusterSummaryTool => Tool(
    name: 'getGraphClusterSummary',
    description:
        'Retrieves a text summary of the neighborhood around a specific node. Useful to understand the context of a potential link.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'centerNodeId': {
          'type': 'integer',
          'description': 'The ID of the node to center the summary around.',
        },
      },
      'required': ['centerNodeId'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final centerNodeId = params['centerNodeId'] as int;

      // Get neighbors via edges
      final edges = await GraphEdge.db.find(
        session,
        where: (e) =>
            e.sourceNodeId.equals(centerNodeId) |
            e.targetNodeId.equals(centerNodeId),
        limit: 10,
      );

      final neighborIds = edges
          .map(
            (e) => e.sourceNodeId == centerNodeId
                ? e.targetNodeId
                : e.sourceNodeId,
          )
          .toSet();

      final neighbors = await GraphNode.db.find(
        session,
        where: (n) => n.id.inSet(neighborIds),
      );

      return {
        'centerNodeId': centerNodeId,
        'neighborCount': neighbors.length,
        'neighbors': neighbors
            .map((n) => {'id': n.id, 'label': n.label})
            .toList(),
      };
    },
  );

  Tool get _checkSpeakerIdentityTool => Tool(
    name: 'checkSpeakerIdentity',
    description:
        'Checks if a speaker exists and returns their system ID. Creates a new speaker record if one does not exist.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'name': {
          'type': 'string',
          'description': 'The name of the speaker.',
        },
      },
      'required': ['name'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final name = params['name'] as String;
      final id = await _mergeOrCreateSpeaker(session, userId, name);
      return {'speakerId': id, 'name': name};
    },
  );

  Tool get _createGraphNodeTool => Tool(
    name: 'createGraphNode',
    description:
        'Inserts a new node into the knowledge graph. Call this when you identify a distinct, new semantic concept that should be persisted.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'label': {'type': 'string'},
        'summary': {'type': 'string'},
        'impactScore': {'type': 'number'},
        'primarySpeakerId': {'type': 'integer'},
        'embeddingId': {
          'type': 'string',
          'description': 'The ID of the embedding vector.',
        },
        'references': {
          'type': 'array',
          'items': {
            'type': 'object',
            'properties': {
              'start': {'type': 'number'},
              'end': {'type': 'number'},
              'quote': {'type': 'string'},
            },
          },
        },
      },
      'required': [
        'label',
        'summary',
        'impactScore',
        'primarySpeakerId',
        'embeddingId',
      ],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final label = params['label'] as String;
      final summary = params['summary'] as String;
      final impactScore = (params['impactScore'] as num).toDouble();
      final primarySpeakerId = params['primarySpeakerId'] as int;
      final embeddingId = params['embeddingId'] as String;
      final referencesList = (params['references'] as List? ?? []);

      final vector = _embeddingRegistry[embeddingId];
      if (vector == null) {
        throw Exception('Embedding ID $embeddingId not found in registry.');
      }

      final references = referencesList
          .map(
            (r) => QuoteReference(
              startTime: (r['start'] as num).toInt(),
              endTime: (r['end'] as num).toInt(),
              verbatimQuote: r['quote'] as String,
            ),
          )
          .toList();

      final node = await GraphNode.db.insertRow(
        session,
        GraphNode(
          userId: userId,
          videoId: videoId ?? '',
          label: label,
          impactScore: impactScore,
          summary: summary,
          primarySpeakerId: primarySpeakerId,
          references: references,
          embedding: vector,
        ),
      );

      return {'nodeId': node.id, 'status': 'created'};
    },
  );

  Tool get _createGraphEdgeTool => Tool(
    name: 'createGraphEdge',
    description:
        'Creates a directed link between two nodes in the graph to represent a semantic relationship.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'sourceNodeId': {'type': 'integer'},
        'targetNodeId': {'type': 'integer'},
        'weight': {
          'type': 'number',
          'description': 'Strength of the relationship (0.0 to 1.0).',
        },
      },
      'required': ['sourceNodeId', 'targetNodeId', 'weight'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final sourceNodeId = params['sourceNodeId'] as int;
      final targetNodeId = params['targetNodeId'] as int;
      final weight = (params['weight'] as num).toDouble();

      final edge = await GraphEdge.db.insertRow(
        session,
        GraphEdge(
          userId: userId,
          sourceNodeId: sourceNodeId,
          targetNodeId: targetNodeId,
          weight: weight,
        ),
      );

      return {'edgeId': edge.id, 'status': 'created'};
    },
  );

  Tool get _searchGraphTool => Tool(
    name: 'searchGraph',
    description:
        'Performs a semantic search on the Knowledge Graph using a natural language query.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'query': {'type': 'string', 'description': 'The search query string.'},
        'threshold': {
          'type': 'number',
          'description': 'Similarity threshold (default 0.4).',
        },
        'limit': {'type': 'integer', 'description': 'Max results (default 5).'},
      },
      'required': ['query'],
    }),
    onCall: (dynamic arguments) async {
      if (llmService == null) {
        throw Exception('LLMService is required for searchGraph');
      }
      final params = arguments as Map<String, dynamic>;
      final query = params['query'] as String;
      final threshold = (params['threshold'] as num?)?.toDouble() ?? 0.4;
      final limit = (params['limit'] as int?) ?? 5;

      final embedding = await llmService!.generateEmbedding(query);
      final nodes = await GraphNode.db.find(
        session,
        where: (n) =>
            n.userId.equals(userId) &
            (n.embedding.distanceCosine(embedding) < threshold),
        orderBy: (n) => n.embedding.distanceCosine(embedding),
        limit: limit,
      );

      return {
        'nodes': nodes
            .map(
              (n) => {
                'id': n.id,
                'label': n.label,
                'summary': n.summary,
                'references': n.references
                    .map(
                      (r) => {
                        'quote': r.verbatimQuote,
                        'start': r.startTime,
                        'end': r.endTime,
                      },
                    )
                    .toList(),
                'videoId': n.videoId,
              },
            )
            .toList(),
      };
    },
  );

  Tool get _traverseGraphTool => Tool(
    name: 'traverseGraph',
    description:
        'Traverses the graph starting from a node to find related concepts.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'startNodeId': {'type': 'integer'},
        'maxHops': {'type': 'integer', 'description': 'Max depth (def 1).'},
      },
      'required': ['startNodeId'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final startNodeId = params['startNodeId'] as int;

      final edges = await GraphEdge.db.find(
        session,
        where: (e) =>
            e.sourceNodeId.equals(startNodeId) |
            e.targetNodeId.equals(startNodeId),
        limit: 10,
      );
      final connectedNodeIds = edges
          .map(
            (e) =>
                e.sourceNodeId == startNodeId ? e.targetNodeId : e.sourceNodeId,
          )
          .toSet();
      final nodes = await GraphNode.db.find(
        session,
        where: (n) => n.id.inSet(connectedNodeIds),
      );

      return {
        'startNodeId': startNodeId,
        'connectedNodes': nodes
            .map((n) => {'id': n.id, 'label': n.label, 'summary': n.summary})
            .toList(),
      };
    },
  );

  Tool get _getSpeakerContextTool => Tool(
    name: 'getSpeakerContext',
    description: 'Retrieves metadata about a speaker.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'speakerId': {'type': 'integer'},
      },
      'required': ['speakerId'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final speakerId = params['speakerId'] as int;
      final speaker = await Speaker.db.findById(session, speakerId);
      if (speaker == null) return {'error': 'Speaker not found'};
      return {
        'speaker': {
          'id': speaker.id,
          'name': speaker.name,
          'detectedCount': speaker.detectedCount,
        },
      };
    },
  );

  Tool get _detectGapsTool => Tool(
    name: 'detectGaps',
    description:
        'Analyzes the current retrieved context and the question to identify missing information.',
    inputSchema: JsonSchema.create({
      'type': 'object',
      'properties': {
        'currentContextSummary': {
          'type': 'string',
          'description': 'Summary of nodes retrieved so far.',
        },
        'question': {'type': 'string'},
      },
      'required': ['currentContextSummary', 'question'],
    }),
    onCall: (dynamic arguments) async {
      final params = arguments as Map<String, dynamic>;
      final context = params['currentContextSummary'] as String;
      if (context.length < 50) {
        return {
          'gap':
              'Context is very sparse. Consider external search or broader graph search.',
        };
      }
      return {'gap': 'Likely covers the basics.'};
    },
  );

  Future<int> _mergeOrCreateSpeaker(
    sp.Session session,
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
        'KnowledgeCurator: found existing speaker: $speakerName (id: ${existingSpeaker.id})',
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

    session.log('KnowledgeCurator: Creating new speaker: $speakerName');
    final speaker = Speaker(
      userId: userId,
      name: speakerName,
      normalizedName: normalizedName,
      detectedCount: 1,
    );

    final insertedSpeaker = await Speaker.db.insertRow(session, speaker);
    return insertedSpeaker.id!;
  }
}
