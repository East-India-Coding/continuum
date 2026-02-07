import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/auth_service.dart';
import 'package:continuum_flutter/application/conversation_service.dart';
import 'package:continuum_flutter/presentation/controllers/conversation_controller.dart';
import 'package:continuum_flutter/presentation/utils/continuum_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatPanel extends ConsumerStatefulWidget {
  const ChatPanel({required this.speakers, this.isDemo = false, super.key});

  final List<Speaker> speakers;
  final bool isDemo;

  @override
  ConsumerState<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends ConsumerState<ChatPanel>
    with AutomaticKeepAliveClientMixin<ChatPanel> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        unawaited(
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        );
      }
    });
  }

  void _sendMessage() {
    if (!ref.read(authServiceProvider).isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to continue')),
      );
      return;
    }

    final text = _chatController.text.trim();
    if (text.isNotEmpty) {
      ref
          .read(conversationControllerProvider(widget.speakers).notifier)
          .sendMessage(text, isDemo: widget.isDemo);
      _chatController.clear();
    }
  }

  TextSpan _buildRichTextSpan(String text) {
    final spans = <InlineSpan>[];
    // Matches content inside double quotes or angle brackets
    final regex = RegExp('(".*?"|<.*?>)');
    var lastMatchEnd = 0;

    for (final match in regex.allMatches(text)) {
      // Add text before the match
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: GoogleFonts.rajdhani(
              color: ContinuumColors.textGrey,
              fontSize: 13,
            ),
          ),
        );
      }

      final matchText = match.group(0)!;

      if (matchText.startsWith('"')) {
        // Italics for quotes
        spans.add(
          TextSpan(
            text: matchText,
            style: GoogleFonts.rajdhani(
              color: ContinuumColors.textGrey,
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        );
      } else if (matchText.startsWith('<')) {
        // Tappable link for brackets
        final url = matchText.substring(1, matchText.length - 1);
        spans.add(
          TextSpan(
            text: matchText,
            style: GoogleFonts.rajdhani(
              color: ContinuumColors.accent,
              fontSize: 13,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final uri = Uri.tryParse(url);
                if (uri != null) {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    // Try adding https if missing scheme
                    final uri2 = Uri.tryParse('https://$url');
                    if (uri2 != null && await canLaunchUrl(uri2)) {
                      await launchUrl(uri2);
                    }
                  }
                }
              },
          ),
        );
      }

      lastMatchEnd = match.end;
    }

    // Add remaining text
    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: GoogleFonts.rajdhani(
            color: ContinuumColors.textGrey,
            fontSize: 13,
          ),
        ),
      );
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final conversationState = ref.watch(
      conversationControllerProvider(widget.speakers),
    );

    ref
      ..listen(
        conversationControllerProvider(
          widget.speakers,
        ).select((s) => s.messages.length),
        (_, _) => _scrollToBottom(),
      )
      ..listen(
        conversationControllerProvider(
          widget.speakers,
        ).select((s) => s.messages.lastOrNull),
        (prev, next) {
          if (conversationState.isStreaming) {
            _scrollToBottom();
          }
        },
      );

    if (conversationState.error != null) {
      return Center(
        child: Text('Conversation Error: ${conversationState.error}'),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            children: [
              const AutoSizeText(
                'ASK THE SPEAKERS',
                maxLines: 1,
                style: TextStyle(
                  color: ContinuumColors.accent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                color: ContinuumColors.accentDark,
              ),
              const SizedBox(width: 4),
              const AutoSizeText(
                'ACTIVE',
                maxLines: 1,
                style: TextStyle(
                  color: ContinuumColors.accentDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              """ANSWERS ARE GROUNDED EXCLUSIVELY IN THE SELECTED SPEAKER'S IDEAS.""",
              maxLines: 2,
              style: GoogleFonts.rajdhani(
                color: ContinuumColors.accentDarker,
                fontWeight: FontWeight.bold,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        _buildChatArea(conversationState),
        _buildSpeakerList(conversationState),
      ],
    );
  }

  Widget _buildSpeakerList(ConversationState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: AutoSizeText(
            'RESPOND AS',
            maxLines: 1,
            style: TextStyle(
              color: ContinuumColors.accent,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: state.speakers.isEmpty
              ? const Center(
                  child: Text(
                    'No speakers found',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.speakers.length,
                  itemBuilder: (context, index) {
                    final speaker = state.speakers[index];
                    final isSelected = state.selectedSpeaker == speaker;

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: InkWell(
                        onTap: () {
                          ref
                              .read(
                                conversationControllerProvider(
                                  widget.speakers,
                                ).notifier,
                              )
                              .selectSpeaker(speaker);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? ContinuumColors.accent
                                      : Colors.grey[500]!,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ContinuumColors.accent,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              speaker.name,
                              style: TextStyle(
                                color: isSelected
                                    ? ContinuumColors.accent
                                    : Colors.grey[400],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildChatArea(ConversationState state) {
    return Expanded(
      child: Column(
        children: [
          if (state.messages.isEmpty)
            Expanded(child: _recommendedQuestionsWidget(state.selectedSpeaker))
          else
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: state.messages.length + (state.isStreaming ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.messages.length && state.isStreaming) {
                    return const SizedBox.shrink();
                  }

                  // Safety check
                  if (index >= state.messages.length) {
                    return const SizedBox.shrink();
                  }

                  final msg = state.messages[index];
                  final isBot = !msg.isUser;

                  if (isBot) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border: Border.all(color: ContinuumColors.accent),
                              color: ContinuumColors.accent.withValues(
                                alpha: 0.1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.api,
                                color: ContinuumColors.accent,
                                size: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AutoSizeText(
                                  'ORACLE_CORE',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: ContinuumColors.accent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                if (msg.thinking != null && state.isStreaming)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      transitionBuilder: (child, animation) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      child: AutoSizeText(
                                        msg.thinking!.length > 150
                                            ? msg.thinking!.substring(
                                                msg.thinking!.length - 150,
                                              )
                                            : msg.thinking!,
                                        key: ValueKey(msg.thinking!.length),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.rajdhani(
                                          color: ContinuumColors.textGrey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      left: BorderSide(
                                        color: ContinuumColors.accent,
                                        width: 2,
                                      ),
                                    ),
                                    color: Color(
                                      0xFF1E1E1E,
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 30,
                                    ),
                                    child: msg.result == '...'
                                        ? SizedBox(
                                            width: 30,
                                            height: 16,
                                            child: JumpingDots(
                                              color: ContinuumColors.accent,
                                              radius: 4,
                                              verticalOffset: -5,
                                              animationDuration: const Duration(
                                                milliseconds: 500,
                                              ),
                                            ),
                                          )
                                        : RichText(
                                            text: _buildRichTextSpan(
                                              msg.result.trim(),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              right: 36,
                            ),
                            child: AutoSizeText(
                              'OPERATOR_01',
                              maxLines: 1,
                              style: TextStyle(
                                color: ContinuumColors.textGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  color: const Color(0xFF252525),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  child: Text(
                                    msg.result,
                                    style: GoogleFonts.rajdhani(
                                      color: ContinuumColors.textGrey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ContinuumColors.textGrey,
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.fingerprint,
                                    color: ContinuumColors.textGrey,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          if (state.isStreaming)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  '••• SYNTHESIZING_VECTORS...',
                  maxLines: 1,
                  style: TextStyle(
                    color: ContinuumColors.accentDark,
                    fontSize: 10,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            color: ContinuumColors.primaryDark,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: ContinuumColors.accent),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _chatController,
                      enabled:
                          !state.isStreaming && state.selectedSpeaker != null,
                      style: const TextStyle(
                        color: ContinuumColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ContinuumColors.accent,
                      decoration: const InputDecoration(
                        hintText: 'ENTER_QUERY...',
                        hintStyle: TextStyle(
                          color: ContinuumColors.accentDark,
                          fontSize: 12,
                          letterSpacing: 1,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  InkWell(
                    onTap: state.isStreaming || state.selectedSpeaker == null
                        ? null
                        : _sendMessage,
                    child: Container(
                      width: 48,
                      height: 48,
                      color: state.isStreaming || state.selectedSpeaker == null
                          ? ContinuumColors.accentDarker
                          : ContinuumColors.accent,
                      child: Center(
                        child: state.isStreaming
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CupertinoActivityIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : const Icon(Icons.bolt, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recommendedQuestionsWidget(Speaker? selectedSpeaker) {
    if (selectedSpeaker == null) {
      return const SizedBox.shrink();
    }

    final questionsValue = ref.watch(
      recommendedQuestionsProvider(selectedSpeaker),
    );
    return questionsValue.when(
      data: (questions) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final question = questions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  ref
                      .read(
                        conversationControllerProvider(
                          widget.speakers,
                        ).notifier,
                      )
                      .sendMessage(question);
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: ContinuumColors.accent),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      question,
                      style: const TextStyle(
                        color: ContinuumColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      error: (error, stack) => const SizedBox.shrink(),
      loading: () => const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
