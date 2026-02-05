import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/serverpod_client.dart';
import 'package:continuum_flutter/constants.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/utils/url_launcher.dart';
import 'package:continuum_flutter/presentation/widgets/animated_background.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_header.dart';
import 'package:continuum_flutter/presentation/widgets/cyberpunk_button.dart';
import 'package:continuum_flutter/presentation/widgets/hover_link_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_indicator/live_indicator.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  bool _isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(serverpodClientProvider);

    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              const ContinuumHeader(),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          _buildStatusBar(),
                          const SizedBox(height: 20),
                          _title(fontSize: 64),
                          const SizedBox(height: 10),
                          _buildSubtitle(),
                          const SizedBox(height: 60),
                          _buildLoginCard(context, client),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildFooterStatus(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title({double fontSize = 24}) => AutoSizeText(
    'CONTINUUM',
    maxLines: 1,
    style: TextStyle(
      color: ContinuumColors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: 4,
      shadows: [
        BoxShadow(
          color: ContinuumColors.accent.withValues(alpha: 0.8),
          blurRadius: 8,
        ),
        BoxShadow(
          color: ContinuumColors.accent.withValues(alpha: 0.4),
          blurRadius: 20,
        ),
      ],
    ),
  );

  Widget _buildLinkText(String text, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HoverLinkText(text: text, onTap: onTap),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF003333)),
        color: const Color(0xFF051A1A),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiveIndicator(
            color: ContinuumColors.accent,
            spreadRadius: 5,
            waitDuration: Durations.long1,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: AutoSizeText(
              'AGENTIC KNOWLEDGE ENGINE',
              maxLines: 1,
              style: GoogleFonts.robotoMono(
                color: ContinuumColors.accent,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return AutoSizeText(
      '''Transform audio streams into interactive knowledge networks for exploration and retention.'''
          .toUpperCase(),
      textAlign: TextAlign.center,
      maxLines: 2,
      style: GoogleFonts.rajdhani(
        color: ContinuumColors.accent,
        fontSize: 14,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, Client client) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: ContinuumColors.primary.withValues(alpha: 0.6),
        border: Border.all(
          color: ContinuumColors.accentDark.withValues(alpha: 0.7),
        ),
      ),
      child: Stack(
        children: [
          // Corner accents
          Positioned(
            top: 0,
            left: 0,
            child: _buildCorner(isTop: true, isLeft: true),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildCorner(isTop: false, isLeft: false),
          ),

          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const AutoSizeText(
                  'ENTER THE GRID',
                  maxLines: 1,
                  style: TextStyle(
                    color: ContinuumColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                AutoSizeText(
                  '''Synchronize your profile to start mapping podcasts into knowledge graphs.'''
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.rajdhani(
                    color: ContinuumColors.textGrey,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                GoogleSignInWidget(
                  client: client,
                  // need to pass empty scopes to avoid double popup issue
                  scopes: const [],
                  buttonWrapper:
                      ({
                        required child,
                        required onPressed,
                        required style,
                      }) => Stack(
                        children: [
                          if (!_isLoggingIn)
                            Opacity(
                              opacity: 0.01,
                              child: child,
                            ),
                          CyberpunkButton(
                            onPressed: _isLoggingIn
                                ? null
                                : () {
                                    setState(() {
                                      _isLoggingIn = true;
                                    });
                                    onPressed?.call();
                                  },
                            text: _isLoggingIn
                                ? 'CONNECTING...'
                                : 'LOGIN WITH GOOGLE',
                            icon: Icons.g_mobiledata,
                          ),
                        ],
                      ),
                  onError: (error) {
                    setState(() {
                      _isLoggingIn = false;
                    });
                    debugPrint(error.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ContinuumColors.accentDarker,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: GoogleFonts.rajdhani(
                          color: ContinuumColors.accentDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ContinuumColors.accentDarker,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CyberpunkButton(
                  onPressed: () {
                    context.go('/demo-graph');
                  },
                  text: 'EXPLORE DEMO GRAPH',
                  icon: Icons.grid_goldenratio,
                  isPrimary: false,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 20,
      height: 20,
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

  Widget _buildFooterStatus() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF111111))),
          ),
          child: Row(
            mainAxisAlignment: isSmallScreen
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (!isSmallScreen) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'POWERED BY',
                      style: TextStyle(
                        color: ContinuumColors.accent,
                        fontSize: 10,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'GEMINI & FLUTTER',
                      style: GoogleFonts.rajdhani(
                        color: ContinuumColors.textGrey,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
              _buildLinkText(
                'SOURCE CODE',
                onTap: () {
                  unawaited(
                    UrlLauncher.launchURLNewTab(ContinuumConstants.githubUrl),
                  );
                },
              ),
              _buildLinkText(
                'DEVPOST PAGE',
                onTap: () {
                  unawaited(
                    UrlLauncher.launchURLNewTab(ContinuumConstants.devpostUrl),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
