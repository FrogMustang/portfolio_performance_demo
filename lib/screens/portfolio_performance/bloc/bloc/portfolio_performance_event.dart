part of 'portfolio_performance_bloc.dart';

@freezed
abstract class PortfolioPerformanceEvent with _$PortfolioPerformanceEvent {
  const factory PortfolioPerformanceEvent.fetchPortfolioChart({
    required PortfolioChartTimespan timespan,
  }) = _FetchPortfolioChart;
}
