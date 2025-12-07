import 'package:flutter/material.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';

/// A big round icon button that automatically adapts to theme changes
class RoundIconButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? bgColor;
  final VoidCallback onPressed;
  final bool isPrimary;

  const RoundIconButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.iconColor,
    this.bgColor,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    // Access colors via Theme.of(context).colors - automatically updates when theme changes
    final colors = context.colors;

    // Determine colors based on theme and widget state
    final backgroundColor =
        bgColor ?? (isPrimary ? colors.buttonPrimary : colors.buttonSecondary);
    final defaultIconColor = isPrimary ? colors.textInverse : colors.iconColorSecondary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? defaultIconColor, size: iconSize ?? 30),
      ),
    );
  }
}
