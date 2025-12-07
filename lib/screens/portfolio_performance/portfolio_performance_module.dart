import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_api.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_repository.dart';

class PortfolioPerformanceModule {
  /// Initialize the mock server (call this before using the bloc)
  static Future<void> initialize() async {
    await PortfolioChartApi.initializeMockServer();
  }

  static Future<void> dispose() async {
    await PortfolioChartApi.stopMockServer();
  }

  static PortfolioPerformanceBloc providePortfolioPerformanceBloc() {
    final repository = PortfolioChartRepository(
      api: PortfolioChartApi(
        host: 'localhost',
        port: 50051,
        useMockData: true, // Use mock gRPC server
      ),
    );

    return PortfolioPerformanceBloc(
      repository: repository,
    );
  }
}
