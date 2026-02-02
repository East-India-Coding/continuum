import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:continuum/application/audio_service.dart';
import 'package:continuum/presentation/utils/continuum_colors.dart';

class ContinuumDialog extends ConsumerWidget {
  const ContinuumDialog({
    required this.title,
    required this.child,
    this.actions,
    super.key,
  });

  final String title;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PointerInterceptor(
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Container(
            decoration: BoxDecoration(
              color: ContinuumColors.primary,
              border: Border.all(color: ContinuumColors.secondary),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              title.toUpperCase(),
                              maxLines: 1,
                              style: const TextStyle(
                                color: ContinuumColors.accent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                          if (actions != null) ...[
                            ...actions!,
                            const SizedBox(width: 16),
                          ],
                          // Close Button
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                ref
                                    .read(audioServiceProvider.notifier)
                                    .playClickSound();
                                Navigator.of(context).pop();
                              },
                              hoverColor: ContinuumColors.accent.withValues(
                                alpha: 0.2,
                              ),
                              child: const BorderedIcon(
                                icon: Icons.close,
                                size: 20,
                                color: ContinuumColors.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(
                        color: ContinuumColors.accentDark,
                        height: 1,
                        thickness: 0.5,
                      ),
                      const SizedBox(height: 16),
                      // Body
                      Flexible(child: child),
                    ],
                  ),
                ),

                // Corners
                const Positioned(
                  top: -1,
                  left: -1,
                  child: _CornerAccent(isTop: true, isLeft: true),
                ),
                const Positioned(
                  bottom: -1,
                  right: -1,
                  child: _CornerAccent(isTop: false, isLeft: false),
                ),

                // Decorative scan lines or dots could go here
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CornerAccent extends StatelessWidget {
  const _CornerAccent({
    required this.isTop,
    required this.isLeft,
  });

  final bool isTop;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? const BorderSide(color: ContinuumColors.accent, width: 2)
              : BorderSide.none,
          bottom: !isTop
              ? const BorderSide(color: ContinuumColors.accent, width: 2)
              : BorderSide.none,
          left: isLeft
              ? const BorderSide(color: ContinuumColors.accent, width: 2)
              : BorderSide.none,
          right: !isLeft
              ? const BorderSide(color: ContinuumColors.accent, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }
}

class BorderedIcon extends StatelessWidget {
  const BorderedIcon({
    required this.icon,
    this.color = Colors.white,
    this.size = 24,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}
