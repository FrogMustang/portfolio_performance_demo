part of 'portfolio_performance_bloc.dart';

enum FetchPortfolioChartStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
abstract class PortfolioPerformanceState with _$PortfolioPerformanceState {
  const factory PortfolioPerformanceState({
    @Default(PortfolioChartTimespan.day) PortfolioChartTimespan timespan,
    @Default(FetchPortfolioChartStatus.initial)
    FetchPortfolioChartStatus fetchPortfolioChartStatus,
    @Default(null) PortfolioChartData? portfolioChartData,
    @Default(null) String? error,
  }) = _PortfolioPerformanceState;
}
