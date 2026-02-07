import 'package:auto_size_text/auto_size_text.dart';
import 'package:continuum_flutter/application/audio_service.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberpunkButton extends ConsumerStatefulWidget {
  const CyberpunkButton({
    required this.onPressed,
    required this.text,
    this.icon,
    this.isPrimary = true,
    super.key,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  final bool isPrimary;

  @override
  ConsumerState<CyberpunkButton> createState() => _CyberpunkButtonState();
}

class _CyberpunkButtonState extends ConsumerState<CyberpunkButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Primary Button Colors
    const primaryBg = Color(0xFF052222);
    const primaryBgHover = Color(0xFF053333);
    const primaryBorder = Color(0xFF005555);
    const primaryBorderHover = Color(0xFF008888);

    // Secondary Button Colors
    const secondaryBg = Colors.transparent;
    const secondaryBgHover = Color(0xFF051A1A);
    const secondaryBorder = Color(0xFF005555);
    const secondaryBorderHover = Color(0xFF008888);
    const secondaryText = Color(0xFF00AAAA);
    const secondaryTextHover = ContinuumColors.accent;

    Color getBackgroundColor() {
      if (widget.isPrimary) {
        return _isHovering ? primaryBgHover : primaryBg;
      }
      return _isHovering ? secondaryBgHover : secondaryBg;
    }

    Color getBorderColor() {
      if (widget.isPrimary) {
        return _isHovering ? primaryBorderHover : primaryBorder;
      }
      return _isHovering ? secondaryBorderHover : secondaryBorder;
    }

    Color getTextColor() {
      if (widget.isPrimary) {
        return Colors.white;
      }
      return _isHovering ? secondaryTextHover : secondaryText;
    }

    List<BoxShadow> getShadows() {
      if (widget.isPrimary) {
        return [
          BoxShadow(
            color: _isHovering
                ? ContinuumColors.accent.withValues(alpha: 0.3)
                : ContinuumColors.accent.withValues(alpha: 0.1),
            blurRadius: _isHovering ? 15 : 10,
            spreadRadius: _isHovering ? 2 : 1,
          ),
        ];
      }
      return _isHovering
          ? [
              BoxShadow(
                color: ContinuumColors.accent.withValues(alpha: 0.05),
                blurRadius: 10,
              ),
            ]
          : [];
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onPressed?.call();
          ref.read(audioServiceProvider.notifier).playClickSound();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 40,
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            border: Border.all(
              color: getBorderColor(),
            ),
            boxShadow: getShadows(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: getTextColor(),
                  size: 20,
                ),
                const SizedBox(width: 12),
              ],
              Flexible(
                child: AutoSizeText(
                  widget.text,
                  maxLines: 1,
                  style: GoogleFonts.orbitron(
                    color: getTextColor(),
                    fontSize: 14,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
