import 'dart:async';

import 'package:continuum_flutter/application/audio_service.dart';
import 'package:continuum_flutter/application/auth_service.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/widgets/podcasts_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContinuumSidebar extends ConsumerWidget {
  const ContinuumSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();
    final authInfoListenable = ref
        .watch(authServiceProvider)
        .authInfoListenable;

    return ValueListenableBuilder(
      valueListenable: authInfoListenable,
      builder: (context, authInfo, child) {
        final isLoggedIn = authInfo != null;

        return Container(
          width: 70,
          decoration: const BoxDecoration(
            border: Border(right: BorderSide(color: Color(0xFF333333))),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _SidebarButton(
                icon: Icons.podcasts,
                tooltip: 'Add Podcast',
                isActive: location == '/home',
                onTap: () => context.go('/home'),
              ),
              const SizedBox(height: 20),
              _SidebarButton(
                icon: Icons.hub,
                tooltip: 'View Graph',
                isActive: location == '/graph',
                isDisabled: !isLoggedIn,
                onTap: () => context.go('/graph'),
              ),
              const SizedBox(height: 20),
              _SidebarButton(
                icon: Icons.list_outlined,
                tooltip: 'List Podcasts',
                isDisabled: !isLoggedIn,
                onTap: () {
                  unawaited(
                    showDialog<void>(
                      context: context,
                      builder: (context) => const PodcastsDialog(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _SidebarButton(
                icon: Icons.bookmark_outline,
                tooltip: 'Bookmarks',
                isActive: location == '/bookmarks',
                isDisabled: !isLoggedIn,
                onTap: () {
                  context.go('/bookmarks');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SidebarButton extends ConsumerStatefulWidget {
  const _SidebarButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isActive = false,
    this.isDisabled = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isActive;
  final bool isDisabled;

  @override
  ConsumerState<_SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends ConsumerState<_SidebarButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isDisabled) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(
          widget.icon,
          size: 20,
          color: ContinuumColors.textGrey.withValues(alpha: 0.3),
        ),
      );
    }

    final isSelected = widget.isActive || _isHovering;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            widget.onTap();
            ref.read(audioServiceProvider.notifier).playClickSound();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? ContinuumColors.accent.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: isSelected ? ContinuumColors.accent : Colors.transparent,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: ContinuumColors.accent.withValues(alpha: 0.2),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: isSelected
                  ? ContinuumColors.accent
                  : ContinuumColors.accentDark,
            ),
          ),
        ),
      ),
    );
  }
}
