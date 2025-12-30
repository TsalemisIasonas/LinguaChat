import 'package:flutter/material.dart';

import 'package:lingua_chat/styles/colors.dart';
import 'package:lingua_chat/widgets/app_bar.dart';
import 'package:lingua_chat/widgets/floating_action_button.dart';
import 'package:lingua_chat/widgets/navigation_bar.dart';
import 'package:lingua_chat/widgets/leaderboard.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: 80,
          height: 80,
          child: LinguaFloatingActionButton(),
        ),

        appBar: linguaAppBar(title_: 'Leaderboard', context: context),

        body: LeaderboardWidget(),

        bottomNavigationBar: const LinguaNavigationBar(),
      ),
    );
  }
}
