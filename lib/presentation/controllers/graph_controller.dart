import 'dart:async';

import 'package:continuum/domain/graph_data.dart';
import 'package:continuum/domain/speaker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'graph_controller.g.dart';

class GraphState {
  const GraphState({
    this.graphData,
    this.isLoading = true,
    this.error,
    this.currentGranularityIndex = 0,
    this.speakers = const [],
    this.selectedSpeakerIds = const {},
  });

  final GraphData? graphData;
  final bool isLoading;
  final String? error;
  final int currentGranularityIndex;
  final List<Speaker> speakers;
  final Set<String> selectedSpeakerIds;

  GraphState copyWith({
    GraphData? graphData,
    bool? isLoading,
    String? error,
    int? currentGranularityIndex,
    List<Speaker>? speakers,
    Set<String>? selectedSpeakerIds,
  }) {
    return GraphState(
      graphData: graphData ?? this.graphData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentGranularityIndex:
          currentGranularityIndex ?? this.currentGranularityIndex,
      speakers: speakers ?? this.speakers,
      selectedSpeakerIds: selectedSpeakerIds ?? this.selectedSpeakerIds,
    );
  }
}

@riverpod
class GraphController extends _$GraphController {
  @override
  GraphState build({bool isDemo = false}) {
    // Load data initially
    unawaited(loadData(isDemo: isDemo));
    return const GraphState();
  }

  Future<void> loadData({bool isDemo = false}) async {
    try {
      // final service = ref.read(graphServiceProvider);
      // final conversationService = ref.read(conversationServiceProvider);
      // final futures = await Future.wait([
      //   service.getGraphData(isDemo: isDemo),
      //   conversationService.listSpeakers(isDemo: isDemo),
      // ]);

      // final data = futures[0] as GraphData;
      // final speakers = futures[1] as List<Speaker>;

      // var granularityIndex = 0;
      // if (data.graphWithGranularity.isNotEmpty) {
      //   granularityIndex = data.graphWithGranularity.length - 1;
      // }

      // state = state.copyWith(
      //   graphData: data,
      //   currentGranularityIndex: granularityIndex,
      //   isLoading: false,
      //   speakers: speakers,
      //   selectedSpeakerIds: speakers.map((s) => s.id!).toSet(),
      // );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  void cycleGranularity() {
    final data = state.graphData;
    if (data == null || data.graphWithGranularity.isEmpty) return;

    final nextIndex =
        (state.currentGranularityIndex + 1) % data.graphWithGranularity.length;

    state = state.copyWith(currentGranularityIndex: nextIndex);
  }

  void toggleSpeaker(String speakerId) {
    final currentSelected = Set<String>.from(state.selectedSpeakerIds);
    if (currentSelected.contains(speakerId)) {
      currentSelected.remove(speakerId);
    } else {
      currentSelected.add(speakerId);
    }
    state = state.copyWith(selectedSpeakerIds: currentSelected);
  }

  Map<String, dynamic> buildChartOptions(GraphState state) {
    final graphData = state.graphData;
    if (graphData == null || graphData.graphWithGranularity.isEmpty) {
      return {};
    }

    // Use the current granular level
    final index = state.currentGranularityIndex.clamp(
      0,
      graphData.graphWithGranularity.length - 1,
    );
    final graph = graphData.graphWithGranularity[index].graph;

    final categories = graph.categories.map((c) => {'name': c.name}).toList();

    final oldToNewIndex = <int, int>{};
    final validNodes = <Map<String, dynamic>>[];

    var newIndex = 0;
    for (var i = 0; i < graph.nodes.length; i++) {
      final node = graph.nodes[i];
      if (state.selectedSpeakerIds.contains(node.primarySpeakerId)) {
        oldToNewIndex[i] = newIndex;
        validNodes.add({
          'id': newIndex,
          'nodeId': node.nodeId,
          'name': node.name,
          'value': node.value,
          'category': node.category,
          'symbolSize': node.symbolSize,
          'videoId': node.videoId,
          'summary': node.summary,
          'primarySpeakerId': node.primarySpeakerId,
          'references': node.references,
          'isBookmarked': node.isBookmarked,
        });
        newIndex++;
      }
    }

    final links = <Map<String, dynamic>>[];
    for (final l in graph.links) {
      if (oldToNewIndex.containsKey(l.source) &&
          oldToNewIndex.containsKey(l.target)) {
        links.add({
          'source': oldToNewIndex[l.source],
          'target': oldToNewIndex[l.target],
        });
      }
    }

    final usedCategoryIndices = <int>{};
    for (final node in validNodes) {
      if (node['category'] is int) {
        usedCategoryIndices.add(node['category'] as int);
      }
    }

    final legendData = <String>[];
    for (var i = 0; i < categories.length; i++) {
      if (usedCategoryIndices.contains(i)) {
        if (categories[i]['name'] != null) {
          legendData.add(categories[i]['name']!);
        }
      }
    }

    return {
      'legend': {
        'data': legendData,
        'orient': 'vertical',
        'left': '20',
        'top': '20',
      },
      'backgroundColor': '#1A1A1A',
      'textStyle': {'fontFamily': 'monospace'},
      'tooltip': {'show': true},
      'series': [
        {
          'type': 'graph',
          'layout': 'force',
          'animation': true,
          'label': {'position': 'right', 'formatter': '{b}'},
          'draggable': true,
          'data': validNodes,
          'categories': categories,
          'force': {
            'edgeLength': 50,
            'repulsion': 100,
            'gravity': 0.1,
          },
          'edges': links,
          'roam': true,
          'lineStyle': {
            'color': 'source',
            'curveness': 0.3,
          },
        },
      ],
    };
  }
}
