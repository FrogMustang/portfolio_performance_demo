part of 'portfolio_overview_bloc.dart';

@freezed
abstract class PortfolioOverviewEvent with _$PortfolioOverviewEvent {
  const factory PortfolioOverviewEvent.fetchPortfolioOverview() = _FetchPortfolioOverview;
}
