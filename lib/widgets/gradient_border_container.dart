import 'package:flutter/material.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  const GradientBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            colors.primaryLight,
            colors.secondaryAccent.withValues(alpha: 0.2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(0.3), // Border width
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.backgroundSecondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
