import 'package:auto_size_text/auto_size_text.dart';
import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/audio_service.dart';
import 'package:continuum_flutter/presentation/controllers/graph_controller.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/widgets/chat_panel.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_dialog.dart';
import 'package:continuum_flutter/presentation/widgets/cyberpunk_button.dart';
import 'package:continuum_flutter/presentation/widgets/node_info_dialog.dart';
import 'package:continuum_flutter/presentation/widgets/speaker_checklist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:graphify/graphify.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ForceDirectedGraphPage extends ConsumerStatefulWidget {
  const ForceDirectedGraphPage({super.key, this.isDemo = false});

  final bool isDemo;

  @override
  ConsumerState<ForceDirectedGraphPage> createState() =>
      _ForceDirectedGraphPageState();
}

class _ForceDirectedGraphPageState
    extends ConsumerState<ForceDirectedGraphPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final graphState = ref.watch(
      graphControllerProvider(isDemo: widget.isDemo),
    );

    final graphController = ref.read(
      graphControllerProvider(isDemo: widget.isDemo).notifier,
    );

    if (graphState.isLoading) {
      return const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(color: ContinuumColors.accent),
        ),
      );
    }

    if (graphState.error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  'Graph Error: ${graphState.error}',
                  style: const TextStyle(color: ContinuumColors.accent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: CyberpunkButton(
                    text: 'RETRY',
                    icon: Icons.refresh,
                    onPressed: () {
                      ref.invalidate(
                        graphControllerProvider(isDemo: widget.isDemo),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (graphState.graphData?.graphWithGranularity.isEmpty ?? true) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AutoSizeText(
                  'No graph data available. Have you added a podcast yet?',
                  style: TextStyle(color: ContinuumColors.accent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: CyberpunkButton(
                    text: 'ADD A PODCAST',
                    icon: Icons.podcasts,
                    onPressed: () {
                      context.go('/home');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        if (isMobile) {
          return Scaffold(
            endDrawer: PointerInterceptor(
              child: Drawer(
                width: constraints.maxWidth * 0.85,
                backgroundColor: ContinuumColors.primaryDark,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 5,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: ContinuumColors.accent,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned.fill(
                        child: _buildControlPanel(graphState, graphController),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: _buildGraph(graphState, graphController),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Builder(
                    builder: (context) {
                      return PointerInterceptor(
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: ContinuumColors.accent,
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: const Icon(
                            Icons.menu_open,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          body: Row(
            children: [
              // Left Panel: Graph
              Expanded(
                flex: 3,
                child: _buildGraph(graphState, graphController),
              ),
              // Divider
              Container(width: 0.5, color: ContinuumColors.accent),
              // Right Panel: Graph config & Chat
              Expanded(
                child: ColoredBox(
                  color: ContinuumColors.primaryDark,
                  child: _buildControlPanel(graphState, graphController),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGraph(GraphState graphState, GraphController graphController) {
    return ColoredBox(
      color: ContinuumColors.primary,
      child: graphState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GraphifyView(
              // Force rebuild/update when granularity/speaker changes
              key: ValueKey(
                '''graph_${graphState.currentGranularityIndex}_${graphState.selectedSpeakerIds}''',
              ),
              controller: GraphifyController(),
              initialOptions: graphController.buildChartOptions(
                graphState,
              ),
              onChartClick: (chartId, data) {
                if (data['dataType'] == 'node') {
                  ref.read(audioServiceProvider.notifier).playClickSound();
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      try {
                        final node = GraphNodeDisplay.fromJson(
                          data['data'] as Map<String, dynamic>,
                        );

                        return NodeInfoDialog(
                          node: node,
                          isDemo: widget.isDemo,
                          speakerName: graphState.speakers
                              .where(
                                (speaker) =>
                                    speaker.id == node.primarySpeakerId,
                              )
                              .firstOrNull
                              ?.name,
                        );
                      } catch (e) {
                        debugPrint(e.toString());
                        return const ContinuumDialog(
                          title: 'Node Info',
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Error loading node info',
                                style: TextStyle(
                                  color: ContinuumColors.accent,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
    );
  }

  Widget _buildControlPanel(
    GraphState graphState,
    GraphController graphController,
  ) {
    return Column(
      children: [
        SpeakerChecklist(
          speakers: graphState.speakers,
          selectedSpeakerIds: graphState.selectedSpeakerIds,
          onToggle: graphController.toggleSpeaker,
        ),
        if ((graphState.graphData?.graphWithGranularity.length ?? 0) > 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CyberpunkButton(
              text: 'Cycle Granularity',
              icon: Icons.rotate_90_degrees_ccw_outlined,
              onPressed: graphController.cycleGranularity,
            ),
          ),
        const SizedBox(height: 10),
        const Divider(
          color: ContinuumColors.accentDark,
          thickness: 0.5,
        ),
        Expanded(
          child: ChatPanel(
            speakers: graphState.speakers,
            isDemo: widget.isDemo,
          ),
        ),
      ],
    );
  }
}
