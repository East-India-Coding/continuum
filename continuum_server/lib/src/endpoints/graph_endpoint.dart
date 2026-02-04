import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/graph_service.dart';

class GraphEndpoint extends Endpoint {
  Future<GraphData> getGraphData(Session session, {bool isDemo = false}) async {
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

    return _getGraphDataForUser(session, userId);
  }

  Future<GraphData> _getGraphDataForUser(
    Session session,
    String userId,
  ) async {
    final nodesFuture = GraphNode.db.find(
      session,
      where: (c) => c.userId.equals(userId),
      orderBy: (c) => c.impactScore,
      orderDescending: true,
    );

    final edgesFuture = GraphEdge.db.find(
      session,
      where: (c) => c.userId.equals(userId),
    );

    final results = await Future.wait([nodesFuture, edgesFuture]);
    final nodes = results[0] as List<GraphNode>;
    final edges = results[1] as List<GraphEdge>;

    if (nodes.isEmpty) {
      return GraphData(graphWithGranularity: []);
    }

    // Calculate node degrees from edges
    final nodeDegrees = <int, int>{};
    for (final edge in edges) {
      nodeDegrees[edge.sourceNodeId] =
          (nodeDegrees[edge.sourceNodeId] ?? 0) + 1;
      nodeDegrees[edge.targetNodeId] =
          (nodeDegrees[edge.targetNodeId] ?? 0) + 1;
    }

    final granularities = <GraphGranularity>[];
    // based on the number of nodes in others -> make a new granularity -> add 3 everytime
    var maxCategoryCount = 3;
    var level = 0;
    while (maxCategoryCount < nodes.length) {
      if (level >= 3) {
        break;
      }

      final (graph, otherNodeCount) = _buildGraphWithGranularity(
        level,
        maxCategoryCount,
        nodes,
        edges,
        nodeDegrees,
      );
      granularities.add(graph);

      if (otherNodeCount <= 4) {
        break;
      }

      maxCategoryCount += 3;
      level++;
    }

    return GraphData(graphWithGranularity: granularities);
  }

  (GraphGranularity, int) _buildGraphWithGranularity(
    int level,
    int maxCategoryCount,
    List<GraphNode> allNodes,
    List<GraphEdge> allEdges,
    Map<int, int> nodeDegrees,
  ) {
    // Filter potential anchors: must have at least 2 edges
    final candidateAnchors = allNodes
        .where((n) => (nodeDegrees[n.id] ?? 0) >= 2)
        .toList();

    // Identify anchors (categories)
    final validCategoryCount = maxCategoryCount > candidateAnchors.length
        ? candidateAnchors.length
        : maxCategoryCount;

    final anchors = candidateAnchors.sublist(0, validCategoryCount);
    final anchorIds = anchors.map((n) => n.id!).toSet();

    // Build Categories List
    final categories = anchors
        .map((n) => GraphCategory(name: n.label))
        .toList();

    // Add 'Other' category if we are not including all nodes as categories
    final hasOther = validCategoryCount < allNodes.length;
    if (hasOther) {
      categories.add(GraphCategory(name: 'Other'));
    }

    // Build Nodes List
    final nodeDisplays = <GraphNodeDisplay>[];
    final nodeIdToIndex = <int, int>{};
    var otherNodeCount = 0;

    for (var i = 0; i < allNodes.length; i++) {
      final node = allNodes[i];
      nodeIdToIndex[node.id!] = i;

      int categoryIndex;
      double symbolSize;

      if (anchorIds.contains(node.id)) {
        // This node is an anchor
        categoryIndex = anchors.indexWhere((a) => a.id == node.id);
        symbolSize = 20;
      } else {
        int bestAnchorIndex = -1; // -1 means Other

        // Find neighbors and their connection weights
        final neighborWeights = <int, double>{};
        for (final edge in allEdges) {
          if (edge.sourceNodeId == node.id) {
            neighborWeights[edge.targetNodeId] = edge.weight;
          } else if (edge.targetNodeId == node.id) {
            neighborWeights[edge.sourceNodeId] = edge.weight;
          }
        }

        // Check which neighbors are anchors - prefer highest weight, then highest impact (lowest index)
        double currentMaxWeight = -1.0;

        for (var idx = 0; idx < anchors.length; idx++) {
          final anchor = anchors[idx];
          if (neighborWeights.containsKey(anchor.id)) {
            final weight = neighborWeights[anchor.id]!;
            if (weight > currentMaxWeight) {
              currentMaxWeight = weight;
              bestAnchorIndex = idx;
            }
          }
        }

        if (bestAnchorIndex != -1) {
          categoryIndex = bestAnchorIndex;
        } else {
          // Assign to "Other"
          categoryIndex = categories.length - 1;
          otherNodeCount++;
        }
        symbolSize = 10;
      }

      nodeDisplays.add(
        GraphNodeDisplay(
          name: node.label,
          nodeId: node.id!,
          videoId: node.videoId,
          summary: node.summary,
          primarySpeakerId: node.primarySpeakerId,
          references: node.references,
          value: node.impactScore,
          category: categoryIndex,
          symbolSize: symbolSize,
          isBookmarked: node.isBookmarked,
        ),
      );
    }

    // Build Links
    final linkDisplays = <GraphLinkDisplay>[];
    for (final edge in allEdges) {
      final sourceIndex = nodeIdToIndex[edge.sourceNodeId];
      final targetIndex = nodeIdToIndex[edge.targetNodeId];

      if (sourceIndex != null && targetIndex != null) {
        linkDisplays.add(
          GraphLinkDisplay(
            source: sourceIndex,
            target: targetIndex,
          ),
        );
      }
    }

    return (
      GraphGranularity(
        granularity: level,
        graph: GraphElements(
          categories: categories,
          nodes: nodeDisplays,
          links: linkDisplays,
        ),
      ),
      otherNodeCount,
    );
  }

  // ignore: unused_element
  Future<void> _deleteGraphForUser(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    await GraphNode.db.deleteWhere(
      session,
      where: (c) => c.userId.equals(userId),
    );
    await GraphEdge.db.deleteWhere(
      session,
      where: (c) => c.userId.equals(userId),
    );

    // await SegmentedTranscript.db.deleteWhere(
    //   session,
    //   where: (c) => c.videoId.notEquals(''),
    // );

    final podcasts = await Podcast.db.find(
      session,
      where: (c) => c.userId.equals(userId),
    );
    for (final podcast in podcasts) {
      await Podcast.db.updateRow(
        session,
        podcast.copyWith(graphExists: false),
      );
    }
  }

  Future<void> bookmarkNode(
    Session session,
    int nodeId,
    bool isBookmarked,
  ) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    await GraphService().bookmarkNode(session, nodeId, isBookmarked);
  }

  Future<List<GraphNode>> getBookmarkedNodes(Session session) async {
    final userId = session.authenticated?.userIdentifier;
    if (userId == null) {
      throw Exception('User not authenticated');
    }
    return await GraphService().getBookmarkedNodes(session, userId);
  }
}
