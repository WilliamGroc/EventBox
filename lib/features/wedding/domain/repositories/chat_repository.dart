import 'package:wedding_witness_app/features/wedding/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getRecentMessages();
}
