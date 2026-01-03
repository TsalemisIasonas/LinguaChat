import 'package:flutter/material.dart';
import 'package:lingua_chat/models/chat_message.dart';
import 'package:lingua_chat/screens/home_screen.dart';
import 'package:lingua_chat/services/openai_service.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lingua_chat/models/user.dart';

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  final List<ChatMessage> messages = [];
  final OpenAIService openAI = OpenAIService();
  
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  bool _isListening = false;
  bool _isProcessing = false;
  String _transcribedText = '';


  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _initializeTts();
  }

  void _initializeTts() async {
    String languageCode = currentUser.language.ttsCode;
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      // Stop listening
      await _speech.stop();
      setState(() {
        _isListening = false;
      });
      
      // If we have transcribed text, send it to API
      if (_transcribedText.isNotEmpty) {
        await _processAndSpeak(_transcribedText);
        _transcribedText = '';
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
      // Get response from API
      final response = await openAI.sendMessage(text);
      
      setState(() {
        messages.add(ChatMessage(text: response, type: MessageType.received));
      });

      // Speak the response
      await _flutterTts.speak(response);
    } catch (e) {
      print('Error processing speech: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
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
                if (_transcribedText.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _transcribedText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
