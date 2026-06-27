import 'package:sarana_gdg_lp/data/services/ai_chat_service.dart';

/// Repository that wraps the AI chat service.
/// Provides a clean interface for ViewModels to consume.
class ChatRepository {
  ChatRepository({required AiChatService chatService})
      : _service = chatService;

  final AiChatService _service;

  /// Returns the initial welcome message from the AI assistant.
  String getWelcomeMessage() => AiChatService.welcomeMessage;

  /// Sends a user [message] and returns the AI-generated response.
  Future<String> sendMessage(String message) {
    return _service.generateResponse(message);
  }
}
