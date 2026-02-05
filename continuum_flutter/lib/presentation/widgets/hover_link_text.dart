import 'package:continuum_flutter/application/audio_service.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HoverLinkText extends ConsumerStatefulWidget {
  const HoverLinkText({
    required this.text,
    required this.onTap,
    this.isActive = false,
    super.key,
  });

  final String text;
  final VoidCallback onTap;
  final bool isActive;

  @override
  ConsumerState<HoverLinkText> createState() => _HoverLinkTextState();
}

class _HoverLinkTextState extends ConsumerState<HoverLinkText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          ref.read(audioServiceProvider.notifier).playClickSound();
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: GoogleFonts.rajdhani(
            color: _isHovered || widget.isActive
                ? ContinuumColors.accent
                : ContinuumColors.textGrey,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            fontSize: 12,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
