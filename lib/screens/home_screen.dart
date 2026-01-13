import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/repositories/user_repository.dart';
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
  final PageController _pageController = PageController(
    viewportFraction: 0.85,
    initialPage: 0,
  );
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadUserOnStartup();
  }

  Future<void> _loadUserOnStartup() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser != null && firebaseUser.email != null) {
      currentUser = await UserRepository().getUser(firebaseUser.email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: LinguaFloatingActionButton(currentScreen: 'home'),
      ),

      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),

      body: Stack(
        children: [
          const LinguaBanner(),
          Padding(
            padding: const EdgeInsets.only(top: 250.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 120),
                  SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double value = 1.0;
                            if (_pageController.position.haveDimensions) {
                              value = _pageController.page! - index;
                              value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
                            }
                            return Center(
                              child: SizedBox(
                                height: Curves.easeInOut.transform(value) * 300,
                                child: child,
                              ),
                            );
                          },
                          child: ModeSelectButton(
                            mode: index == 0 ? 'Conversation' : 'Speaking',
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      2,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const LinguaNavigationBar(currentScreen: 'home'),
    );
  }
}
