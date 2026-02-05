import 'package:auto_size_text/auto_size_text.dart';
import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/auth_service.dart';
import 'package:continuum_flutter/application/graph_service.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class NodeInfoDialog extends ConsumerStatefulWidget {
  const NodeInfoDialog({
    required this.node,
    this.speakerName,
    super.key,
  });

  final GraphNodeDisplay node;
  final String? speakerName;

  @override
  ConsumerState<NodeInfoDialog> createState() => _NodeInfoDialogState();
}

class _NodeInfoDialogState extends ConsumerState<NodeInfoDialog> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isBookmarked = widget.node.isBookmarked;
      });
    });
  }

  Future<void> _toggleBookmark() async {
    final newValue = !isBookmarked;
    setState(() {
      isBookmarked = newValue;
    });

    try {
      if (!ref.read(authServiceProvider).isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to bookmark nodes')),
        );
        throw Exception('Not logged in');
      }

      await ref
          .read(graphServiceProvider)
          .bookmarkNode(
            widget.node.nodeId,
            isBookmarked: newValue,
          );
      ref.invalidate(bookmarkedNodesProvider);
    } catch (e) {
      if (mounted) {
        setState(() {
          isBookmarked = !newValue;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContinuumDialog(
      title: 'Node Info',
      actions: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggleBookmark,
            borderRadius: BorderRadius.circular(20),
            hoverColor: ContinuumColors.accent.withValues(alpha: 0.2),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color: ContinuumColors.accent,
                size: 20,
              ),
            ),
          ),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', widget.node.name),
          if (widget.speakerName != null) ...[
            const SizedBox(height: 12),
            _buildInfoRow(
              'Primary Speaker',
              widget.speakerName!,
            ),
          ],
          const SizedBox(height: 12),
          const AutoSizeText(
            'Summary',
            maxLines: 1,
            style: TextStyle(
              color: ContinuumColors.accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.node.summary,
            style: const TextStyle(
              color: ContinuumColors.textGrey,
              height: 1.4,
            ),
          ),
          if (widget.node.references.isNotEmpty) ...[
            const SizedBox(height: 20),
            const AutoSizeText(
              'References',
              maxLines: 1,
              style: TextStyle(
                color: ContinuumColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.node.references.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ref = widget.node.references[index];
                  final startTimeInt = ref.startTime;
                  final youtubeUrl =
                      'https://www.youtube.com/watch?v=${widget.node.videoId}&t=$startTimeInt';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"${ref.verbatimQuote}"',
                        style: const TextStyle(
                          color: ContinuumColors.textGrey,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(youtubeUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.play_circle_outline,
                              size: 16,
                              color: ContinuumColors.accent,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: AutoSizeText(
                                '''Watch at ${formatDuration(Duration(seconds: startTimeInt))}''',
                                maxLines: 1,
                                style: const TextStyle(
                                  color: ContinuumColors.accent,
                                  decoration: TextDecoration.underline,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          label,
          maxLines: 1,
          style: const TextStyle(
            color: ContinuumColors.accent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        SelectableText(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
