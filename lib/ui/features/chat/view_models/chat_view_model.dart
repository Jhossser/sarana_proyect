import 'package:flutter/material.dart';
import 'package:sarana_gdg_lp/data/repositories/chat_repository.dart';
import 'package:sarana_gdg_lp/domain/models/chat_message.dart';

/// ViewModel for the AIChatScreen.
/// Manages message list, loading state and dispatches messages to the repository.
class ChatViewModel extends ChangeNotifier {
  ChatViewModel({required ChatRepository chatRepository})
      : _repository = chatRepository {
    _initWelcomeMessage();
  }

  final ChatRepository _repository;

  final List<ChatMessage> _messages = [];
  bool _isTyping = false;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;

  void _initWelcomeMessage() {
    _messages.add(ChatMessage(
      id: 'welcome',
      text: _repository.getWelcomeMessage(),
      isFromAi: true,
      timestamp: DateTime.now(),
    ));
  }

  /// Sends a user message and fetches the AI response.
  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    // Add user message
    _messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: trimmed,
      isFromAi: false,
      timestamp: DateTime.now(),
    ));
    _isTyping = true;
    notifyListeners();

    try {
      final response = await _repository.sendMessage(trimmed);
      _messages.add(ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_ai',
        text: response,
        isFromAi: true,
        timestamp: DateTime.now(),
      ));
    } catch (_) {
      _messages.add(ChatMessage(
        id: '${DateTime.now().millisecondsSinceEpoch}_err',
        text: 'Lo siento, tuve un problema al responder. ¿Podrías intentarlo de nuevo? 🙏',
        isFromAi: true,
        timestamp: DateTime.now(),
      ));
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }
}
