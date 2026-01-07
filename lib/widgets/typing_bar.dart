import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/speaking_screen.dart';

class TypingBar extends StatefulWidget {
  final Function(String message) onSend;   // <-- Added callback

  const TypingBar({super.key, required this.onSend});

  @override
  State<TypingBar> createState() => _TypingBarState();
}

class _TypingBarState extends State<TypingBar> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _goToSpeakingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SpeakingScreen(),
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isNotEmpty) {
      widget.onSend(text);         // <-- send message to ChatScreen
      print('\n\n\n\n\n\nmessage sent\n\n\n\n\n\n\n');
      _messageController.clear();  // <-- keep UI same
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Microphone button
          GestureDetector(
            onTap: _goToSpeakingScreen,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.mic,
                size: 28,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Text input field
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),

          const SizedBox(width: 8),

          // Send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF6C63FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
