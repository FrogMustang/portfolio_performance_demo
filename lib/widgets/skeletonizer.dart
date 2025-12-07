import 'package:flutter/material.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonizer extends StatelessWidget {
  final bool enabled;
  final Widget child;
  final bool ignoreContainers;
  final Color? containersColor;

  const AppSkeletonizer({
    super.key,
    required this.enabled,
    required this.child,
    this.ignoreContainers = false,
    this.containersColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Skeletonizer(
      enabled: enabled,
      ignoreContainers: ignoreContainers,
      containersColor: containersColor ?? colors.cardBackground,
      effect: ShimmerEffect(
        baseColor: colors.backgroundPrimary,
        highlightColor: colors.backgroundSecondary,
      ),
      child: child,
    );
  }
}
