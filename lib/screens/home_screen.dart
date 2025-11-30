import 'package:flutter/material.dart';
import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/floating_action_button.dart';
import 'package:lingua_chat/widgets/banner.dart';
import 'package:lingua_chat/widgets/mode_select_button.dart';
import 'package:lingua_chat/widgets/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: LinguaFloatingActionButton(),
      ),

      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Stack(
        children: [
          const LinguaBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Center(
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  padEnds: true,
                  children: const [
                    ModeSelectButton(mode: 'Conversation'),
                    ModeSelectButton(mode: 'Speaking'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const LinguaNavigationBar(),
    );
  }
}
