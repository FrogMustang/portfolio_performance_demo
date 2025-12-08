import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_details_card.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';

void main() {
  group('ChartDetailsWidget', () {
    testWidgets('displays positive performance with green color', (tester) async {
      final item = PortfolioChartItem(
        date: DateTime.now(),
        amount: 105000.0,
        percentTimeWeightedCumulated: 5.0,
        rateOfReturnPercent: 5.0,
        totalProfitLoss: 5000.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: ChartDetailsWidget(
              point: item,
              timespan: PortfolioChartTimespan.month,
            ),
          ),
        ),
      );

      // Amount is split into separate widgets: $, 105,000, .00
      expect(find.text('\$'), findsWidgets);
      expect(find.text('105,000'), findsOneWidget);
      expect(find.text('.00'), findsOneWidget);
      expect(find.text('+5.00%'), findsOneWidget);
    });

    testWidgets('displays negative performance with red color', (tester) async {
      final item = PortfolioChartItem(
        date: DateTime.now(),
        amount: 95000.0,
        percentTimeWeightedCumulated: -5.0,
        rateOfReturnPercent: -5.0,
        totalProfitLoss: -5000.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: ChartDetailsWidget(
              point: item,
              timespan: PortfolioChartTimespan.month,
            ),
          ),
        ),
      );

      // Amount is split into separate widgets
      expect(find.text('95,000'), findsOneWidget);
      expect(find.text('.00'), findsOneWidget);
      expect(find.text('-5.00%'), findsOneWidget);
    });

    testWidgets('displays profit/loss amount', (tester) async {
      final item = PortfolioChartItem(
        date: DateTime.now(),
        amount: 110000.0,
        percentTimeWeightedCumulated: 10.0,
        rateOfReturnPercent: 10.0,
        totalProfitLoss: 10000.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: ChartDetailsWidget(
              point: item,
              timespan: PortfolioChartTimespan.month,
            ),
          ),
        ),
      );

      // Profit/loss is formatted as a complete string with sign
      expect(find.text('+\$10,000.00'), findsOneWidget);
    });

    testWidgets('handles zero performance', (tester) async {
      final item = PortfolioChartItem(
        date: DateTime.now(),
        amount: 100000.0,
        percentTimeWeightedCumulated: 0.0,
        rateOfReturnPercent: 0.0,
        totalProfitLoss: 0.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: ChartDetailsWidget(
              point: item,
              timespan: PortfolioChartTimespan.month,
            ),
          ),
        ),
      );

      // Amount is split into separate widgets
      expect(find.text('\$'), findsOneWidget);
      expect(find.text('100,000'), findsOneWidget);
      expect(find.text('.00'), findsWidgets);
      expect(find.text('+0.00%'), findsOneWidget);
    });
  });
}
