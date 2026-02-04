import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/serverpod_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_service.g.dart';

class GraphService {
  GraphService(this._client);
  final Client _client;

  Future<GraphData> getGraphData({bool isDemo = false}) {
    return _client.graph.getGraphData(isDemo: isDemo);
  }

  Future<void> bookmarkNode(int nodeId, {required bool isBookmarked}) {
    return _client.graph.bookmarkNode(nodeId, isBookmarked);
  }

  Future<List<GraphNode>> getBookmarkedNodes() {
    return _client.graph.getBookmarkedNodes();
  }
}

@Riverpod(keepAlive: true)
GraphService graphService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return GraphService(client);
}

@riverpod
Future<List<GraphNode>> bookmarkedNodes(Ref ref) async {
  final graphService = ref.watch(graphServiceProvider);
  return graphService.getBookmarkedNodes();
}
