class ChatMessage {
  final int id;
  final String content;
  final String author;
  final DateTime createdAt;

  ChatMessage({
    required this.id,
    required this.content,
    required this.author,
    required this.createdAt,
  });
}
