import 'package:portfolio_performance_demo/utils/constants.dart';

enum PortfolioChartTimespan {
  day(
    name: Constants.portfolioChartTimespanDay,
    displayName: '1D',
    timestampLabel: 'Last 24h',
  ),
  week(
    name: Constants.portfolioChartTimespanWeek,
    displayName: '1W',
    timestampLabel: 'Last week',
  ),
  month(
    name: Constants.portfolioChartTimespanMonth,
    displayName: '1M',
    timestampLabel: 'Last month',
  ),
  threeMonths(
    name: Constants.portfolioChartTimespanThreeMonths,
    displayName: '3M',
    timestampLabel: 'Last 3 months',
  ),
  year(
    name: Constants.portfolioChartTimespanYear,
    displayName: '1Y',
    timestampLabel: 'Last year',
  ),
  fiveYears(
    name: Constants.portfolioChartTimespanFiveYears,
    displayName: '5Y',
    timestampLabel: 'Last 5 years',
  )
  ;

  const PortfolioChartTimespan({
    required this.name,
    required this.displayName,
    required this.timestampLabel,
  });

  /// Used to identify the timespan in the API request
  final String name;

  /// What is displayed when this value is selected
  final String displayName;

  /// What timestamp label is displayed in the portfolio performance chart when this value is selected
  final String timestampLabel;
}
