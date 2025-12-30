import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/typing_bar.dart';
import 'package:lingua_chat/models/chat_message.dart';
import 'package:lingua_chat/services/openai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> messages = [];
  final ScrollController scrollController = ScrollController();
  final OpenAIService openAI = OpenAIService();

  void sendMessage(String text) async {
    setState(() {
      messages.add(ChatMessage(text: text, type: MessageType.sent));
    });

    scrollToBottom();

    final response = await openAI.sendMessage(text);

    setState(() {
      messages.add(ChatMessage(text: response, type: MessageType.received));
    });

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Conversation'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [gradientColorStart, gradientColorEnd],
              ),
            ),
          ),

          /// Chat messages
          Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment: msg.type == MessageType.sent
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: msg.type == MessageType.sent
                          ? Colors.blue
                          : Colors.purple,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      msg.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Typing input bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: TypingBar(onSend: sendMessage),
          ),
        ],
      ),
    );
  }
}
