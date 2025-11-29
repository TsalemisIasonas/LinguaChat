import 'package:flutter/material.dart';

class LinguaBottomNavBarItem {
  final IconData icon;
  final String label;

  const LinguaBottomNavBarItem({
    required this.icon,
    required this.label,
  });
}

class LinguaBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const LinguaBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  List<LinguaBottomNavBarItem> get _items => const [
        LinguaBottomNavBarItem(icon: Icons.home_filled, label: 'Home'),
        LinguaBottomNavBarItem(icon: Icons.chat_bubble_rounded, label: 'Chats'),
        LinguaBottomNavBarItem(icon: Icons.school_rounded, label: 'Practice'),
        LinguaBottomNavBarItem(icon: Icons.person_rounded, label: 'Profile'),
      ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF246BFD);
    const inactiveColor = Color(0xFF9CA3AF);
    const backgroundColor = Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (index) {
          final item = _items[index];
          final bool isSelected = index == currentIndex;

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => onItemSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? primaryColor.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 22,
                      color: isSelected ? primaryColor : inactiveColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? primaryColor : inactiveColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}