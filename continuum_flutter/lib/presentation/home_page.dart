import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:continuum_flutter/application/audio_service.dart';
import 'package:continuum_flutter/presentation/controllers/home_controller.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/widgets/animated_background.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _urlController = TextEditingController();
  final ScrollController _logScrollController = ScrollController();

  // Logs for visual effect
  final List<String> _logs = [];
  String? _lastStatus;

  @override
  void dispose() {
    _urlController.dispose();
    _logScrollController.dispose();
    super.dispose();
  }

  Future<void> _handleGenerate() async {
    final url = _urlController.text.trim();
    if (url.isNotEmpty) {
      _logs.clear();
      _lastStatus = null;
      await ref.read(homeControllerProvider.notifier).generate(url);
    }
  }

  void _updateLogs(String? status) {
    if (status == null) return;

    if (_lastStatus != status) {
      final now = DateTime.now();
      final timeStr =
          """${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}""";

      setState(() {
        if (_lastStatus != null && _logs.isNotEmpty) {
          // Append done to last log if it's not already done
          final lastLog = _logs.last;
          if (!lastLog.endsWith('DONE')) {
            _logs[_logs.length - 1] = '$lastLog ... DONE';
          }
        }

        _logs.add('[$timeStr] ${status.toUpperCase()}...');
        _lastStatus = status;
      });

      // Auto scroll to bottom
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_logScrollController.hasClients) {
          unawaited(
            _logScrollController.animateTo(
              _logScrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // listen to changes to update logs
    ref
      ..listen(homeControllerProvider.select((s) => s.ingestionJob?.stage), (
        previous,
        next,
      ) {
        _updateLogs(next);
      })
      ..listen(homeControllerProvider.select((s) => s.ingestionJob?.progress), (
        previous,
        next,
      ) {
        if (next == 100) {
          Future.delayed(const Duration(seconds: 1), () {
            if (context.mounted) {
              context.go('/graph');
            }
          });
        }
      });

    final homeState = ref.watch(homeControllerProvider);
    final ingestionJob = homeState.ingestionJob;
    final isSubmitting = homeState.isSubmitting;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                padding: const EdgeInsets.all(24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child:
                      (ingestionJob == null ||
                              ingestionJob.status == 'failed') &&
                          !isSubmitting
                      ? _buildInputForm(homeState.errorMessage)
                      : _buildProgressView(homeState),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputForm(String? errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: const ValueKey('input_form'),
      children: [
        AutoSizeText(
          'PODCAST',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: GoogleFonts.orbitron(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            letterSpacing: 4,
          ),
        ),
        AutoSizeText(
          'INGESTION',
          textAlign: TextAlign.center,
          maxLines: 1,
          style: GoogleFonts.orbitron(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: ContinuumColors.accent,
            letterSpacing: 4,
            shadows: [
              BoxShadow(
                color: ContinuumColors.accent.withValues(alpha: 0.8),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Subtitle
        AutoSizeText(
          '''Convert long-form podcast into structured, explorable knowledge graphs in real time.'''
              .toUpperCase(),
          textAlign: TextAlign.center,
          maxLines: 3,
          style: GoogleFonts.rajdhani(
            color: ContinuumColors.accentDark,
            fontSize: 16,
            letterSpacing: 2,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 60),

        // Cyberpunk Input Field
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            border: Border.all(color: ContinuumColors.accentDark),
            boxShadow: [
              BoxShadow(
                color: ContinuumColors.accent.withValues(alpha: 0.1),
                blurRadius: 8,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              const Icon(Icons.podcasts, color: ContinuumColors.accent),
              const SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: _urlController,
                  style: GoogleFonts.shareTechMono(
                    color: ContinuumColors.accent,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    hintText: 'INPUT YOUTUBE URL...',
                    hintStyle: GoogleFonts.shareTechMono(
                      color: ContinuumColors.accentDark,
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                    errorText: errorMessage != null ? '' : null,
                  ),
                  onSubmitted: (_) => _handleGenerate(),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'SOURCE: YOUTUBE',
                    style: GoogleFonts.rajdhani(
                      color: ContinuumColors.accentDark,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'MODE: AUDIO STREAM',
                    style: GoogleFonts.rajdhani(
                      color: ContinuumColors.accentDark,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),

        const SizedBox(height: 50),

        // Action Button
        Center(
          child: HoverCyberButton(
            onPressed: _handleGenerate,
            text: 'Start Graph Construction'.toUpperCase(),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressView(HomeState homeState) {
    final ingestionJob = homeState.ingestionJob;
    var progress = ingestionJob?.progress ?? 0;

    if (progress < 5) progress = 5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: const ValueKey('progress_view'),
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hub, color: ContinuumColors.accent, size: 24),
            const SizedBox(width: 12),
            Flexible(
              child: AutoSizeText(
                'CONSTRUCTING NODES...',
                maxLines: 2,
                style: GoogleFonts.orbitron(
                  color: ContinuumColors.accent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    BoxShadow(
                      color: ContinuumColors.accent.withValues(alpha: 0.6),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AutoSizeText(
          'EXTRACTING KNOWLEDGE ENTITIES',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: GoogleFonts.rajdhani(
            color: ContinuumColors.accentDark,
            fontSize: 14,
            letterSpacing: 4,
          ),
        ),

        const SizedBox(height: 60),

        // Progress Bar container
        Container(
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFF110000),
            border: Border.all(color: const Color(0xFF330000)),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: constraints.maxWidth * (progress / 100),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ContinuumColors.accentDark,
                          ContinuumColors.accent,
                        ],
                      ),
                    ),
                  ),
                  // Subtle grid pattern on bar
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 40),

        // Console Log
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            border: Border.all(
              color: ContinuumColors.accent.withValues(alpha: 0.1),
            ),
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: _logScrollController,
              itemCount: _logs.length + 1,
              itemBuilder: (context, index) {
                if (index == _logs.length) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, child) {
                      return AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            '_',
                            textStyle: GoogleFonts.shareTechMono(
                              color: ContinuumColors.accent,
                            ),
                            speed: const Duration(milliseconds: 500),
                          ),
                        ],
                      );
                    },
                    onEnd: () {},
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    _logs[index],
                    style: GoogleFonts.shareTechMono(
                      color: ContinuumColors.accent,
                      fontSize: 14,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class HoverCyberButton extends ConsumerStatefulWidget {
  const HoverCyberButton({
    required this.onPressed,
    required this.text,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  ConsumerState<HoverCyberButton> createState() => _HoverCyberButtonState();
}

class _HoverCyberButtonState extends ConsumerState<HoverCyberButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onPressed();
          ref.read(audioServiceProvider.notifier).playClickSound();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: AnimatedBackground(
            gradientColors: const [
              ContinuumColors.accent,
              ContinuumColors.accentDark,
              ContinuumColors.accent,
              ContinuumColors.accentDark,
            ],
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ContinuumColors.accent.withValues(
                      alpha: _isHovering ? 0.6 : 0.01,
                    ),
                    blurRadius: _isHovering ? 20 : 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      widget.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.tune, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ContinuumColors.accentDark.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    const spacing = 40.0;

    for (var i = 0.0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (var i = 0.0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
