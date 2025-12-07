import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';
import 'package:portfolio_performance_demo/utils/amount_formatter.dart';

class ChartDetailsWidget extends StatelessWidget {
  final PortfolioChartItem point;

  const ChartDetailsWidget({
    super.key,
    required this.point,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFormattedAmount(context, point.amount, textStyles, colors),
          const SizedBox(height: 8),
          _buildProfitLossInfo(context, point, textStyles, colors),
        ],
      ),
    );
  }

  Widget _buildFormattedAmount(
    BuildContext context,
    double amount,
    AppTextStyles textStyles,
    AppColors colors,
  ) {
    final parts = AmountFormatter.splitFormattedAmount(amount);
    final currency = '\$'; // Currency symbol
    final integerPart = parts[0];
    final decimalPart = parts[1];

    final smallStyle = textStyles.bodyLarge;
    final largeStyle = textStyles.displayMedium;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // CURRENCY
        Text(
          currency,
          style: smallStyle,
        ),
        // INTEGER
        Text(
          integerPart,
          style: largeStyle,
        ),
        // DECIMALS
        Text(
          decimalPart,
          style: smallStyle,
        ),
      ],
    );
  }

  Widget _buildProfitLossInfo(
    BuildContext context,
    PortfolioChartItem point,
    AppTextStyles textStyles,
    AppColors colors,
  ) {
    final timespan = context.watch<PortfolioPerformanceBloc>().state.timespan;

    final isProfit = point.totalProfitLoss >= 0;
    final profitLossColor = isProfit ? colors.positiveColor : colors.negativeColor;

    final absProfitLoss = point.totalProfitLoss.abs();

    final formattedAmount = AmountFormatter.formatAmountWithCurrency(absProfitLoss);
    final sign = isProfit ? '+' : '-';
    final displayText = '$sign\$$formattedAmount';

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // LABEL
            Text(
              timespan.timestampLabel.toUpperCase(),
              style: textStyles.labelSmall,
            ),

            // Rate of return percentage
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  displayText,
                  style: textStyles.labelSmall.copyWith(
                    color: profitLossColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 40),

        // Total profit/loss amount
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("RATE OF RETURN", style: textStyles.labelSmall),

            // Rate of return percentage
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${point.rateOfReturnPercent >= 0 ? '+' : ''}${point.rateOfReturnPercent.toStringAsFixed(2)}%',
                  style: textStyles.labelMedium.copyWith(
                    color: profitLossColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
