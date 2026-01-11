import 'package:flutter/material.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/styles/text_styles.dart';
import 'package:lingua_chat/widgets/typing_bar.dart';
import 'package:lingua_chat/models/chat_message.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/services/openai_service.dart';
import 'package:lingua_chat/constants/prompts.dart';
import 'package:lingua_chat/repositories/user_repository.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> messages = [];
  final ScrollController scrollController = ScrollController();
  final OpenAIService openAI = OpenAIService();
  final List<Map<String, String>> conversationHistory = [];
  bool isFirstMessage = true;

  @override
  void initState() {
    super.initState();
    // Send the initial prompt automatically when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendInitialPrompt();
    });
  }

  void _sendInitialPrompt() async {
    final initialPrompt = getTutorInitialPrompt(currentUser.language.label, currentUser.level.name);
    
    conversationHistory.add({
      "role": "system",
      "content": initialPrompt,
    });


    // Get the AI's first greeting
    final response = await openAI.sendMessage(
      "Hello",
      conversationHistory: conversationHistory,
    );

    conversationHistory.add({
      "role": "assistant",
      "content": response,
    });

    setState(() {
      messages.add(ChatMessage(text: response, type: MessageType.received));
      isFirstMessage = false;
    });

    scrollToBottom();
  }

  void sendMessage(String text) async {
    setState(() {
      messages.add(ChatMessage(text: text, type: MessageType.sent));
      currentUser.totalMessages++;
    });

    // Add user message to conversation history
    conversationHistory.add({
      "role": "user",
      "content": text,
    });

    scrollToBottom();

    final response = await openAI.sendMessage(
      text,
      conversationHistory: conversationHistory,
    );
    
    // Check if response contains a correction (starts with NOTE:)
    if (response.trim().startsWith('NOTE:')) {
      setState(() {
        currentUser.messagesWithCorrections++;
      });
    }

    setState(() {
      currentUser.score = currentUser.lessonsStarted * 70 + (currentUser.totalMessages - currentUser.messagesWithCorrections) * 30;
    });
    
    // Save updated stats to database
    UserRepository().addOrUpdateUser(currentUser);

    // Add assistant response to conversation history
    conversationHistory.add({
      "role": "assistant",
      "content": response,
    });

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
    
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: gradientColorStart,
        elevation: 1,
        shadowColor: Colors.black,
        title: Column(
          children: [
            Text('Conversation', style: AppTextStyles.appBarTextStyle,),
          ],
        ),
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

          Center(
            child: Image.asset(  
              'assets/images/app_logo.png',
              fit: BoxFit.cover,
              width: 300,
              height: 300,
            ),
          ),

          /// Chat messages
          Padding(
            padding: const EdgeInsets.only(bottom: 100, left: 10, right: 10, top: 20),
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
                      style: AppTextStyles.messageTextStyle,
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 100),

          /// Typing input bar
          Positioned(
            bottom: bottomPadding,
            left: 0,
            right: 0,
            child: TypingBar(onSend: sendMessage),
          ),
        ],
      ),
    );
  }
}