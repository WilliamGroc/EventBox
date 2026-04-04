import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/chat_message.dart';
import 'package:wedding_witness_app/injection_container.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController {
  StreamSubscription<ChatMessage>? _subscription;

  @override
  Future<List<ChatMessage>> build() async {
    final history = await ref.read(getChatMessagesProvider)();

    _subscription?.cancel();
    final datasource = ref.read(chatDatasourceProvider);
    _subscription = datasource.newMessages.listen((message) {
      final current = state.asData?.value ?? [];
      state = AsyncValue.data([...current, message]);
    });

    ref.onDispose(() => _subscription?.cancel());

    return history;
  }

  void sendMessage(String content, String author) {
    if (content.trim().isEmpty || author.trim().isEmpty) return;
    final datasource = ref.read(chatDatasourceProvider);
    datasource.sendMessage(content.trim(), author.trim());
  }
}
