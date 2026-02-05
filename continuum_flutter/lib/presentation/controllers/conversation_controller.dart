import 'dart:async';

import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/conversation_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_controller.g.dart';

class ChatMessage {
  const ChatMessage({
    required this.result,
    required this.thinking,
    required this.isUser,
  });

  final String result;
  final String? thinking;
  final bool isUser;

  ChatMessage copyWith({String? result, String? thinking, bool? isUser}) {
    return ChatMessage(
      result: result ?? this.result,
      thinking: thinking ?? this.thinking,
      isUser: isUser ?? this.isUser,
    );
  }
}

class ConversationState {
  const ConversationState({
    this.speakers = const [],
    this.selectedSpeaker,
    this.messages = const [],
    this.isStreaming = false,
    this.error,
  });

  final List<Speaker> speakers;
  final Speaker? selectedSpeaker;
  final List<ChatMessage> messages;
  final bool isStreaming;
  final String? error;

  ConversationState copyWith({
    List<Speaker>? speakers,
    Speaker? selectedSpeaker,
    List<ChatMessage>? messages,
    bool? isStreaming,
    String? error,
  }) {
    return ConversationState(
      speakers: speakers ?? this.speakers,
      selectedSpeaker: selectedSpeaker ?? this.selectedSpeaker,
      messages: messages ?? this.messages,
      isStreaming: isStreaming ?? this.isStreaming,
      error: error ?? this.error,
    );
  }
}

@riverpod
class ConversationController extends _$ConversationController {
  @override
  ConversationState build(List<Speaker> speakers) {
    return ConversationState(
      speakers: speakers,
      selectedSpeaker: speakers.isEmpty ? null : speakers.first,
    );
  }

  void selectSpeaker(Speaker? speaker) {
    state = state.copyWith(selectedSpeaker: speaker);
  }

  Future<void> sendMessage(String text, {bool isDemo = false}) async {
    if (text.isEmpty || state.selectedSpeaker == null || state.isStreaming) {
      return;
    }

    final currentMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(result: text, thinking: null, isUser: true))
      ..add(const ChatMessage(result: '...', thinking: '...', isUser: false));

    state = state.copyWith(
      messages: currentMessages,
      isStreaming: true,
    );

    try {
      final service = ref.read(conversationServiceProvider);
      final stream = service.askQuestion(
        text,
        state.selectedSpeaker!,
        isDemo: isDemo,
      );

      await for (final chunk in stream) {
        final messages = List<ChatMessage>.from(state.messages);
        if (messages.isNotEmpty && !messages.last.isUser) {
          final lastMsg = messages.last;
          messages.last = lastMsg.copyWith(
            result: lastMsg.result == '...'
                ? chunk.result
                : lastMsg.result + (chunk.result ?? ''),
            thinking: lastMsg.thinking == '...'
                ? chunk.thinking
                : (lastMsg.thinking ?? '') + (chunk.thinking ?? ''),
          );
          state = state.copyWith(messages: messages);
        }
      }
    } catch (e) {
      final messages = List<ChatMessage>.from(state.messages)
        ..add(ChatMessage(result: 'Error: $e', thinking: null, isUser: false));
      state = state.copyWith(messages: messages);
    } finally {
      state = state.copyWith(isStreaming: false);
    }
  }
}
