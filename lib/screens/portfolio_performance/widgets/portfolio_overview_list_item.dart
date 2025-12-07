import 'package:flutter/material.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';
import 'package:portfolio_performance_demo/utils/amount_formatter.dart';

class PortfolioOverviewListItem extends StatelessWidget {
  final PortfolioWatchlistItem item;

  const PortfolioOverviewListItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;
    final isProfit = item.totalProfitLoss >= 0;
    final profitLossColor = isProfit ? colors.positiveColor : colors.negativeColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          // ASSET ICON
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: colors.backgroundSecondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.account_balance_wallet,
              size: 20,
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        style: textStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.symbol,
                      style: textStyles.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.shares.toStringAsFixed(2)} shares',
                  style: textStyles.bodySmall.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // TOTAL AMOUNT INVESTED
              Text(
                AmountFormatter.formatAmountWithCurrency(item.totalInvestedAmount),
                style: textStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              // PROFIT/LOSS WITH PERCENTAGE
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // PROFIT/LOSS AMOUNT
                  Text(
                    '${item.totalProfitLoss >= 0 ? '+' : ''}'
                    '${AmountFormatter.formatAmountWithCurrency(item.totalProfitLoss)}',
                    style: textStyles.bodySmall.copyWith(
                      color: profitLossColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),

                  // RATE OF RETURN PERCENTAGE
                  Text(
                    '(${item.rateOfReturnPercent >= 0 ? '+' : ''}'
                    '${item.rateOfReturnPercent.toStringAsFixed(2)}%)',
                    style: textStyles.bodySmall.copyWith(
                      color: profitLossColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
