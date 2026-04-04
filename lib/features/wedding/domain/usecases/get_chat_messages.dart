import 'package:wedding_witness_app/features/wedding/domain/entities/chat_message.dart';
import 'package:wedding_witness_app/features/wedding/domain/repositories/chat_repository.dart';

class GetChatMessages {
  final ChatRepository repository;
  GetChatMessages(this.repository);

  Future<List<ChatMessage>> call() => repository.getRecentMessages();
}
