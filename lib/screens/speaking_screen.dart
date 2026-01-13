import 'package:flutter/material.dart';
import 'package:lingua_chat/models/chat_message.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/services/openai_service.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/styles/text_styles.dart';
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
    
    // Set speech rate based on language
    double speechRate = switch (languageCode) {
      'it-IT' => 0.6,      
      'fr-FR' => 0.6,      
      'de-DE' => 0.6,      
      'en-US' => 0.6,      
      _ => 0.6,            
    };
    
    await _flutterTts.setSpeechRate(speechRate);
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
    final initialPrompt = getSpeakingInitialPrompt(currentUser.language.label, currentUser.level.name);
    conversationHistory.add({
      "role": "system",
      "content": initialPrompt,
    });
  }

  Future<void> _toggleListening() async {
    // If processing, stop everything
    if (_isProcessing) {
      setState(() {
        _isProcessing = false;
        _transcribedText = '';
      });
      return;
    }

    // If currently speaking, stop it
    if (_isSpeaking) {
      await _flutterTts.stop();
      setState(() {
        _isSpeaking = false;
      });
      return;
    }

    if (_isListening) {
      // Stop listening and wait for final transcription
      await _speech.stop();
      
      // Give speech recognition time to finalize the transcription
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (_transcribedText.isNotEmpty) {
        final textToProcess = _transcribedText;
        setState(() {
          _isListening = false;
          _transcribedText = '';
          _isProcessing = true;
        });
        await _processAndSpeak(textToProcess);
      } else {
        setState(() {
          _isListening = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No speech detected. Please speak and try again.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
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
    // _isProcessing is already set to true before calling this function
    setState(() {
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
        backgroundColor: gradientColorStart,
        elevation: 1,
        shadowColor: Colors.black,
        title: Text('Speaking', style: AppTextStyles.appBarTextStyle,),
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
                      border: Border.all(
                        color: _isListening ? Colors.white : Colors.transparent,
                        width: 6,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/microphone_logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Status indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _isListening
                        ? (_transcribedText.isEmpty ? '🎤 Listening...' : '🎤 "$_transcribedText"')
                        : _isProcessing
                            ? '⏳ Processing...'
                            : _isSpeaking
                                ? '🔊 Speaking...'
                                : 'Tap to speak',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
