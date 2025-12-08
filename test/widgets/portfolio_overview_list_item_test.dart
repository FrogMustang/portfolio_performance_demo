import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_overview_list_item.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';

void main() {
  group('PortfolioOverviewListItem', () {
    testWidgets('displays al data correctly', (tester) async {
      final item = PortfolioWatchlistItem(
        name: 'Apple Inc.',
        symbol: 'AAPL',
        rateOfReturnPercent: 18.45,
        totalProfitLoss: 1845.50,
        totalInvestedAmount: 10000.0,
        shares: 50.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: PortfolioOverviewListItem(item: item),
          ),
        ),
      );

      expect(find.text('Apple Inc.'), findsOneWidget);
      expect(find.text('AAPL'), findsOneWidget);
      expect(find.text('50.00 shares'), findsOneWidget);
      expect(find.text('10,000.00'), findsOneWidget);
      expect(find.text('+1,845.50'), findsOneWidget);
      expect(find.text('(+18.45%)'), findsOneWidget);
    });

    testWidgets('displays loss with negative sign', (tester) async {
      final item = PortfolioWatchlistItem(
        name: 'Losing Stock',
        symbol: 'LOSS',
        rateOfReturnPercent: -15.0,
        totalProfitLoss: -1500.0,
        totalInvestedAmount: 10000.0,
        shares: 100.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: PortfolioOverviewListItem(item: item),
          ),
        ),
      );

      expect(find.text('-1,500.00'), findsOneWidget);
      expect(find.text('(-15.00%)'), findsOneWidget);
    });

    testWidgets('handles long stock names with ellipsis', (tester) async {
      final item = PortfolioWatchlistItem(
        name: 'Very Long Company Name That Should Be Truncated',
        symbol: 'LONG',
        rateOfReturnPercent: 18.45,
        totalProfitLoss: 1845.50,
        totalInvestedAmount: 10000.0,
        shares: 50.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: SizedBox(
              width: 400,
              child: PortfolioOverviewListItem(item: item),
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(
        find.text('Very Long Company Name That Should Be Truncated'),
      );
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.maxLines, 1);
    });

    testWidgets('handles zero profit/loss', (tester) async {
      final item = PortfolioWatchlistItem(
        name: 'Flat Stock',
        symbol: 'FLAT',
        rateOfReturnPercent: 0.0,
        totalProfitLoss: 0.0,
        totalInvestedAmount: 10000.0,
        shares: 100.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: PortfolioOverviewListItem(item: item),
          ),
        ),
      );

      expect(find.text('+0.00'), findsOneWidget);
      expect(find.text('(+0.00%)'), findsOneWidget);
    });
  });
}
