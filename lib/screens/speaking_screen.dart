import 'package:flutter/material.dart';
import 'package:lingua_chat/models/chat_message.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/services/openai_service.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/constants/prompts.dart';

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  final List<ChatMessage> messages = [];
  final OpenAIService openAI = OpenAIService();
  final List<Map<String, String>> conversationHistory = [];
  
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  bool _isProcessing = false;
  bool _isSpeaking = false;
  bool _isFirstMessage = true;
  String _transcribedText = '';


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _initializeTts();
    _initializeConversation();
  }

  void _initializeTts() async {
    String languageCode = currentUser.language.ttsCode;
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
    
    // Set up callback when TTS finishes speaking
    _flutterTts.setCompletionHandler(() {
      setState(() {
        _isSpeaking = false;
      });
    });
  }

  void _initializeConversation() {
    // Add the initial tutor prompt to conversation history
    final initialPrompt = getTutorInitialPrompt(currentUser.language.label, currentUser.level.name);
    conversationHistory.add({
      "role": "system",
      "content": initialPrompt,
    });
  }

  Future<void> _toggleListening() async {
    // If currently speaking, stop it
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() {
        _isListening = false;
      });
      
      if (_transcribedText.isNotEmpty) {
        await _processAndSpeak(_transcribedText);
        setState(() {
          _transcribedText = '';
        });
      }
    } else {
      // Request microphone permission
      var status = await Permission.microphone.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission denied')),
        );
        return;
      }

      // Start listening
      bool available = await _speech.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );

      if (available) {
        setState(() {
          _isListening = true;
          _transcribedText = '';
        });

        String languageCode = currentUser.language.ttsCode;
        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcribedText = result.recognizedWords;
            });
          },
          localeId: languageCode,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition not available')),
        );
      }
    }
  }

  Future<void> _processAndSpeak(String text) async {
    setState(() {
      _isProcessing = true;
      messages.add(ChatMessage(text: text, type: MessageType.sent));
    });

    try {
      // Add user message to conversation history
      conversationHistory.add({
        "role": "user",
        "content": text,
      });

      // Get response from API with conversation history
      final response = await openAI.sendMessage(
        text,
        conversationHistory: conversationHistory,
      );
      
      // Add assistant response to conversation history
      conversationHistory.add({
        "role": "assistant",
        "content": response,
      });
      
      setState(() {
        messages.add(ChatMessage(text: response, type: MessageType.received));
        _isProcessing = false;
        _isSpeaking = true;
      });

      // Speak the response
      await _flutterTts.speak(response);
    } catch (e) {
      print('Error processing speech: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  void dispose() {
    _speech.cancel();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Speaking'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Microphone button with border when active
                GestureDetector(
                  onTap: _toggleListening,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: _isListening
                          ? Border.all(
                              color: Colors.white,
                              width: 4,
                            )
                          : null,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/microphone_logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // // Status text
                // if (_isListening)
                //   const Text(
                //     'Listening...',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // if (_isProcessing)
                //   const Text(
                //     'Processing...',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                
                const SizedBox(height: 16),
                
                // Transcribed text
                // if (_transcribedText.isNotEmpty)
                //   Container(
                //     margin: const EdgeInsets.symmetric(horizontal: 24),
                //     padding: const EdgeInsets.all(16),
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.2),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Text(
                //       _transcribedText,
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 16,
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
