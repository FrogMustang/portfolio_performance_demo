import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/utils/constants.dart';

void main() {
  group('PortfolioChartTimespan', () {
    test('has correct display names', () {
      expect(PortfolioChartTimespan.day.displayName, '1D');
      expect(PortfolioChartTimespan.week.displayName, '1W');
      expect(PortfolioChartTimespan.month.displayName, '1M');
      expect(PortfolioChartTimespan.threeMonths.displayName, '3M');
      expect(PortfolioChartTimespan.year.displayName, '1Y');
      expect(PortfolioChartTimespan.fiveYears.displayName, '5Y');
    });

    test('has correct internal names', () {
      expect(PortfolioChartTimespan.day.name, Constants.portfolioChartTimespanDay);
      expect(PortfolioChartTimespan.week.name, Constants.portfolioChartTimespanWeek);
      expect(PortfolioChartTimespan.month.name, Constants.portfolioChartTimespanMonth);
      expect(
        PortfolioChartTimespan.threeMonths.name,
        Constants.portfolioChartTimespanThreeMonths,
      );
      expect(PortfolioChartTimespan.year.name, Constants.portfolioChartTimespanYear);
      expect(
        PortfolioChartTimespan.fiveYears.name,
        Constants.portfolioChartTimespanFiveYears,
      );
    });

    test('all enum values have unique display names', () {
      final displayNames = PortfolioChartTimespan.values
          .map((e) => e.displayName)
          .toSet();
      expect(displayNames.length, PortfolioChartTimespan.values.length);
    });

    test('all enum values have unique names', () {
      final names = PortfolioChartTimespan.values.map((e) => e.name).toSet();
      expect(names.length, PortfolioChartTimespan.values.length);
    });
  });
}
