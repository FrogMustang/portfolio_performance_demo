part of 'portfolio_overview_bloc.dart';

enum FetchPortfolioOverviewStatus {
  initial,
  loading,
  success,
  error,
}

@freezed
abstract class PortfolioOverviewState with _$PortfolioOverviewState {
  const factory PortfolioOverviewState({
    @Default(FetchPortfolioOverviewStatus.initial) FetchPortfolioOverviewStatus status,
    @Default(null) PortfolioOverviewData? data,
    @Default(null) String? error,
  }) = _PortfolioOverviewState;
}
