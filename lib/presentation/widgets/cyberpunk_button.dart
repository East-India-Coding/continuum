import 'package:auto_size_text/auto_size_text.dart';
import 'package:continuum/application/audio_service.dart';
import 'package:continuum/presentation/utils/continuum_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberpunkButton extends ConsumerStatefulWidget {
  const CyberpunkButton({
    required this.onPressed,
    required this.text,
    required this.icon,
    this.isPrimary = true,
    super.key,
  });

  final VoidCallback? onPressed;
  final String text;
  final IconData icon;
  final bool isPrimary;

  @override
  ConsumerState<CyberpunkButton> createState() => _CyberpunkButtonState();
}

class _CyberpunkButtonState extends ConsumerState<CyberpunkButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    // Primary Button Colors
    const primaryBg = Color(0xFF220505);
    const primaryBgHover = Color(0xFF330505);
    const primaryBorder = Color(0xFF550000);
    const primaryBorderHover = Color(0xFF880000);

    // Secondary Button Colors
    const secondaryBg = Colors.transparent;
    const secondaryBgHover = Color(0xFF1A0505);
    const secondaryBorder = Color(0xFF550000);
    const secondaryBorderHover = Color(0xFF880000);
    const secondaryText = Color(0xFFAA0000);
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
                ? Colors.redAccent.withValues(alpha: 0.3)
                : Colors.redAccent.withValues(alpha: 0.1),
            blurRadius: _isHovering ? 15 : 10,
            spreadRadius: _isHovering ? 2 : 1,
          ),
        ];
      }
      return _isHovering
          ? [
              BoxShadow(
                color: Colors.redAccent.withValues(alpha: 0.05),
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
              Icon(
                widget.icon,
                color: getTextColor(),
                size: 20,
              ),
              const SizedBox(width: 12),
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
