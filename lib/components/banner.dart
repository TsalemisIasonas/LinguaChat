import 'package:flutter/material.dart';

class LinguaBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? leadingIcon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final Color? backgroundColor;

  const LinguaBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.actionLabel,
    this.onActionPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF246BFD);
    const textPrimary = Color(0xFF0F1828);
    const textSecondary = Color(0xFF707991);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFE7F0FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (leadingIcon != null)
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                leadingIcon,
                color: primaryColor,
                size: 24,
              ),
            ),
          if (leadingIcon != null) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: textSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (actionLabel != null && onActionPressed != null) ...[
            const SizedBox(width: 12),
            TextButton(
              onPressed: onActionPressed,
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}