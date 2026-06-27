/// Domain model representing a single message in the AI chat.
class ChatMessage {
  final String id;
  final String text;
  final bool isFromAi;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isFromAi,
    required this.timestamp,
  });
}
