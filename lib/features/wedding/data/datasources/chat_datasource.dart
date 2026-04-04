import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wedding_witness_app/features/wedding/data/models/chat_message_model.dart';
import 'package:wedding_witness_app/features/wedding/domain/entities/chat_message.dart';

abstract class ChatDatasource {
  Stream<ChatMessage> get newMessages;
  void sendMessage(String content, String author);
  void dispose();
}

class ChatDatasourceImpl implements ChatDatasource {
  late final WebSocketChannel _channel;
  final StreamController<ChatMessage> _controller =
      StreamController<ChatMessage>.broadcast();

  ChatDatasourceImpl(String wsUrl) {
    _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
    _channel.stream.listen(
      (message) {
        try {
          final data = jsonDecode(message as String) as Map<String, dynamic>;
          _controller.add(ChatMessageModel.fromJson(data));
        } catch (_) {}
      },
      onError: (e) => _controller.addError(e),
      onDone: () => _controller.close(),
    );
  }

  @override
  Stream<ChatMessage> get newMessages => _controller.stream;

  @override
  void sendMessage(String content, String author) {
    final payload = jsonEncode({'content': content, 'author': author});
    _channel.sink.add(payload);
  }

  @override
  void dispose() {
    _channel.sink.close();
    if (!_controller.isClosed) _controller.close();
  }
}
