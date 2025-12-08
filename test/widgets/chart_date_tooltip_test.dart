import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart' as intl;
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_date_tooltip.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest(PortfolioChartItem point) {
    return MaterialApp(
      theme: AppTheme.getTheme(AppThemeMode.retailBank),
      home: Scaffold(
        body: Center(
          child: ChartDateTooltip(point: point),
        ),
      ),
    );
  }

  group('ChartDateTooltip', () {
    testWidgets('displays formatted date correctly', (tester) async {
      final date = DateTime(2024, 3, 15, 14, 30);
      final point = PortfolioChartItem(
        date: date,
        amount: 100000.0,
        percentTimeWeightedCumulated: 5.0,
        rateOfReturnPercent: 5.0,
        totalProfitLoss: 5000.0,
      );

      await tester.pumpWidget(createWidgetUnderTest(point));

      final dateFormat = intl.DateFormat('E, d MMM HH:mm');
      final expectedText = dateFormat.format(date);

      expect(find.text(expectedText), findsOneWidget);
    });

    testWidgets('formats date with correct pattern', (tester) async {
      // Friday, March 15, 2024 at 14:30
      final date = DateTime(2024, 3, 15, 14, 30);
      final point = PortfolioChartItem(
        date: date,
        amount: 100000.0,
        percentTimeWeightedCumulated: 5.0,
        rateOfReturnPercent: 5.0,
        totalProfitLoss: 5000.0,
      );

      await tester.pumpWidget(createWidgetUnderTest(point));

      expect(find.text('Fri, 15 Mar 14:30'), findsOneWidget);
    });
  });
}
