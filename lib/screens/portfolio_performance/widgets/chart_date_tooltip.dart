import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';

class ChartDateTooltip extends StatelessWidget {
  final PortfolioChartItem point;

  const ChartDateTooltip({
    super.key,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final dateFormat = intl.DateFormat('E, d MMM HH:mm');
    final formattedDate = dateFormat.format(point.date);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colors.dividerColor.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        formattedDate,
        style: textStyles.labelSmall.copyWith(
          color: colors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
