import 'package:flutter/material.dart';

import 'package:lingua_chat/screens/chat_screen.dart';
import 'package:lingua_chat/screens/speaking_screen.dart';
import 'package:lingua_chat/services/sound_service.dart';

class ModeSelectButton extends StatelessWidget {
  const ModeSelectButton({super.key, required this.mode});

  final String mode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey, width: 2),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              // Image fills entire card
              Positioned.fill(
                child: mode == 'Conversation'
                    ? Image.asset(
                        'assets/images/conversation_carousel.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/speaking_carousel.png',
                        fit: BoxFit.cover,
                      ),
              ),
              // Text overlay at the top
              Positioned(
                bottom: 24,
                left: 24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mode,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      mode == 'Conversation'
                          ? 'Have an in chat conversation with your own AI tutor'
                          : 'Have a realistic voice chat conversation',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        AppSound.click.play();
        mode == 'Conversation'
            ? Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SpeakingScreen()),
              );
      },
    );
  }
}
