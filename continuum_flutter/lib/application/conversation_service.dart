import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/serverpod_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'conversation_service.g.dart';

class ConversationService {
  ConversationService(this._client);
  final Client _client;

  Future<List<Speaker>> listSpeakers({bool isDemo = false}) {
    return _client.conversation.listSpeakers(isDemo: isDemo);
  }

  Stream<AgentResponse> askQuestion(
    String text,
    Speaker speaker, {
    bool isDemo = false,
  }) {
    return _client.conversation.askQuestion(text, speaker, isDemo: isDemo);
  }
}

@Riverpod(keepAlive: true)
ConversationService conversationService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return ConversationService(client);
}
