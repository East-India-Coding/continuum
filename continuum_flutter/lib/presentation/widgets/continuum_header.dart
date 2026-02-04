import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:continuum_flutter/application/audio_service.dart';
import 'package:continuum_flutter/application/auth_service.dart';
import 'package:continuum_flutter/constants.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:continuum_flutter/presentation/utils/url_launcher.dart';
import 'package:continuum_flutter/presentation/widgets/hover_link_text.dart';
import 'package:continuum_flutter/presentation/widgets/continuum_dialog.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class ContinuumHeader extends ConsumerWidget {
  const ContinuumHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authInfoListenable = ref
        .watch(authServiceProvider)
        .authInfoListenable;
    final authService = ref.read(authServiceProvider);
    final isMusicPlaying = ref.watch(audioServiceProvider);
    final audioNotifier = ref.read(audioServiceProvider.notifier);

    var location = '';
    try {
      location = GoRouterState.of(context).uri.toString();
    } catch (_) {}

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 800;

        return Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFF333333))),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  audioNotifier.playClickSound();
                  context.go('/');
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/logo.svg',
                        width: 28,
                        height: 28,
                      ),
                      const SizedBox(width: 12),
                      _title(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              if (!isSmallScreen) ...[
                _buildLinkText(
                  'WHAT IS CONTINUUM',
                  onTap: () {
                    audioNotifier.playClickSound();
                    showDialog<void>(
                      context: context,
                      builder: (context) => ContinuumDialog(
                        title: 'What is Continuum?',
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '''Continuum extracts structured knowledge from podcasts and organizes it into an interactive graph. Each idea is connected, source-grounded, and queryable, turning passive listening into a durable, explorable knowledge system.''',
                              style: GoogleFonts.rajdhani(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () async {
                                UrlLauncher.launchURLNewTab(
                                  ContinuumConstants.continuumYtLink,
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.play_circle_outline,
                                    size: 16,
                                    color: ContinuumColors.accent,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: AutoSizeText(
                                      '''Watch on YouTube''',
                                      maxLines: 1,
                                      style: TextStyle(
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
                        ),
                      ),
                    );
                  },
                ),
                _buildLinkText(
                  'DEMO GRAPH',
                  isActive: location == '/demo-graph',
                  onTap: () {
                    audioNotifier.playClickSound();
                    context.go('/demo-graph');
                  },
                ),
              ],
              IconButton(
                onPressed: audioNotifier.toggleMusic,
                icon: Icon(
                  isMusicPlaying ? Icons.volume_up : Icons.volume_off,
                  color: isMusicPlaying
                      ? ContinuumColors.accent
                      : ContinuumColors.textGrey,
                ),
                tooltip: isMusicPlaying ? 'Stop Music' : 'Play Music',
              ),
              ValueListenableBuilder(
                valueListenable: authInfoListenable,
                builder: (context, authInfo, child) {
                  if (authInfo == null) return const SizedBox.shrink();
                  final userProfileValue = ref.watch(
                    getCurrentUserProfileProvider,
                  );

                  return userProfileValue.when(
                    data: (userProfile) {
                      if (userProfile == null) return const SizedBox.shrink();
                      return Row(
                        children: [
                          const SizedBox(width: 16),
                          _buildProfileSection(
                            context,
                            userProfile,
                            onSignOutTap: () {
                              audioNotifier.playClickSound();
                              authService.signOut();
                            },
                          ),
                        ],
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (error, stackTrace) => const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileSection(
    BuildContext context,
    UserProfileModel userInfo, {
    required VoidCallback onSignOutTap,
  }) {
    return PopupMenuButton(
      offset: const Offset(0, 50),
      color: ContinuumColors.secondary,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ContinuumColors.accent),
        borderRadius: BorderRadius.circular(4),
      ),
      itemBuilder: (context) => [
        PopupMenuItem<void>(
          onTap: onSignOutTap,
          child: const Text(
            'LOGOUT',
            style: TextStyle(
              color: ContinuumColors.white,
              fontSize: 11,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: ContinuumColors.accent),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
                image: userInfo.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(userInfo.imageUrl.toString()),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: userInfo.imageUrl == null
                  ? const Icon(Icons.person, color: Colors.grey, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              userInfo.userName?.toUpperCase() ?? 'USER',
              style: const TextStyle(
                color: ContinuumColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(width: 12),
          ],
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

  Widget _buildLinkText(
    String text, {
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HoverLinkText(text: text, onTap: onTap, isActive: isActive),
    );
  }
}
