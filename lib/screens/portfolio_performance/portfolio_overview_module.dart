import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_overview_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_api.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_repository.dart';

class PortfolioOverviewModule {
  /// Initialize the mock server (call this before using the bloc)
  static Future<void> initialize() async {
    await PortfolioOverviewApi.initializeMockServer();
  }

  static Future<void> dispose() async {
    await PortfolioOverviewApi.stopMockServer();
  }

  static PortfolioOverviewBloc providePortfolioOverviewBloc() {
    final repository = PortfolioOverviewRepository(
      api: PortfolioOverviewApi(
        host: 'localhost',
        port: 50051,
        useMockData: true,
      ),
    );

    return PortfolioOverviewBloc(repository: repository);
  }
}
