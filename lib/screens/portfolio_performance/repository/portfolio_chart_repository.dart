import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_api.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';

abstract class IPortfolioChartRepository {
  Future<PortfolioChartData> getPortfolioChart({String? timespan});

  /// Clean up resources
  Future<void> dispose();
}

class PortfolioChartRepository implements IPortfolioChartRepository {
  final IPortfolioChartApi api;

  PortfolioChartRepository({
    required this.api,
  });

  @override
  Future<PortfolioChartData> getPortfolioChart({String? timespan}) async {
    try {
      final response = await api.getPortfolioChart(timespan: timespan);
      return PortfolioChartData.fromProto(response);
    } catch (error, stackTrace) {
      logger.e(
        'Failed to fetch portfolio chart',
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to fetch portfolio chart: $error');
    }
  }

  @override
  Future<void> dispose() async {
    await api.close();
  }
}
