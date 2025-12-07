import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_overview_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_api.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';

abstract class IPortfolioOverviewRepository {
  Future<PortfolioOverviewData> getPortfolioOverview();

  /// Clean up resources
  Future<void> dispose();
}

class PortfolioOverviewRepository implements IPortfolioOverviewRepository {
  final IPortfolioOverviewApi api;

  PortfolioOverviewRepository({
    required this.api,
  });

  @override
  Future<PortfolioOverviewData> getPortfolioOverview() async {
    try {
      final response = await api.getPortfolioOverview();
      return PortfolioOverviewData.fromProto(response);
    } catch (error, stackTrace) {
      logger.e(
        'Failed to fetch portfolio overview',
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to fetch portfolio overview: $error');
    }
  }

  @override
  Future<void> dispose() async {
    await api.close();
  }
}
