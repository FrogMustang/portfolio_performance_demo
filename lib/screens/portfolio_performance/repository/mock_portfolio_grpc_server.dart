import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:portfolio_performance_demo/generated/portfolio_chart.pbgrpc.dart';
import 'package:portfolio_performance_demo/generated/google/protobuf/timestamp.pb.dart'
    as timestamp_pb;
import 'package:portfolio_performance_demo/utils/constants.dart';

/// Mock gRPC server implementation for testing
/// This simulates a real gRPC server and returns mock data
class MockPortfolioChartService extends PortfolioChartServiceBase {
  @override
  Future<PortfolioChartResponse> getPortfolioChart(
    ServiceCall call,
    PortfolioChartRequest request,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final items = generateMockData(request.hasTimespan() ? request.timespan : '');

    return PortfolioChartResponse(items: items);
  }

  static List<PortfolioChartItem> generateMockData(String? timespan) {
    final now = DateTime.now();
    final List<PortfolioChartItem> items = [];
    const double baseAmount = 100000;

    // Define number of points and sampling interval based on timespan
    int numberOfPoints;
    Duration samplingInterval;

    switch (timespan) {
      case Constants.portfolioChartTimespanDay: // 1D
        numberOfPoints = 24;
        samplingInterval = const Duration(hours: 1);
        break;
      case Constants.portfolioChartTimespanWeek: // 1W
        numberOfPoints = 7;
        samplingInterval = const Duration(days: 1);
        break;
      case Constants.portfolioChartTimespanMonth: // 1M
        numberOfPoints = 30;
        samplingInterval = const Duration(days: 1);
        break;
      case Constants.portfolioChartTimespanThreeMonths: // 3M
        numberOfPoints = 90;
        samplingInterval = const Duration(days: 1);
        break;
      case Constants.portfolioChartTimespanYear: // 1Y
        numberOfPoints = 52;
        samplingInterval = const Duration(days: 7);
        break;
      case Constants.portfolioChartTimespanFiveYears: // 5Y
        numberOfPoints = 60;
        samplingInterval = const Duration(days: 30);
        break;
      default:
        // Default to 1M if timespan is not recognized
        numberOfPoints = 30;
        samplingInterval = const Duration(days: 1);
    }

    // Generate data points with fixed amounts
    // Calculate start date based on timespan
    DateTime startDate;

    switch (timespan) {
      case Constants.portfolioChartTimespanDay: // 1D: Start from today at 00:00
        startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
        break;
      case Constants.portfolioChartTimespanWeek: // 1W: Start from 7 days ago at 00:00
        final weekAgo = now.subtract(const Duration(days: 7));
        startDate = DateTime(weekAgo.year, weekAgo.month, weekAgo.day, 0, 0, 0);
        break;
      case Constants.portfolioChartTimespanMonth: // 1M: Start from 30 days ago at 00:00
        final monthAgo = now.subtract(const Duration(days: 30));
        startDate = DateTime(monthAgo.year, monthAgo.month, monthAgo.day, 0, 0, 0);
        break;
      case Constants
          .portfolioChartTimespanThreeMonths: // 3M: Start from 90 days ago at 00:00
        final threeMonthsAgo = now.subtract(const Duration(days: 90));
        startDate = DateTime(
          threeMonthsAgo.year,
          threeMonthsAgo.month,
          threeMonthsAgo.day,
          0,
          0,
          0,
        );
        break;
      case Constants.portfolioChartTimespanYear: // 1Y: Start from 52 weeks ago at 00:00
        final yearAgo = now.subtract(const Duration(days: 364));
        startDate = DateTime(yearAgo.year, yearAgo.month, yearAgo.day, 0, 0, 0);
        break;
      case Constants
          .portfolioChartTimespanFiveYears: // 5Y: Start from 60 months ago at 00:00
        final fiveYearsAgo = now.subtract(const Duration(days: 1800));
        startDate = DateTime(
          fiveYearsAgo.year,
          fiveYearsAgo.month,
          fiveYearsAgo.day,
          0,
          0,
          0,
        );
        break;
      default:
        // Default to 1M
        final monthAgo = now.subtract(const Duration(days: 30));
        startDate = DateTime(monthAgo.year, monthAgo.month, monthAgo.day, 0, 0, 0);
    }

    // Generate points from startDate, but don't exceed "now"
    double currentAmount = baseAmount;

    for (int i = 0; i < numberOfPoints; i++) {
      final date = startDate.add(samplingInterval * i);

      // Don't add points that are in the future
      if (date.isAfter(now)) {
        break;
      }

      final timestamp = timestamp_pb.Timestamp.fromDateTime(date);

      // Calculate progress through the timespan (0.0 to 1.0)
      final totalDuration = now.difference(startDate);
      final pointDuration = date.difference(startDate);
      final progress = totalDuration.inMilliseconds > 0
          ? pointDuration.inMilliseconds / totalDuration.inMilliseconds
          : 0.0;

      // Add a slight upward trend (about 2-5% over the period depending on timespan)
      double trendMultiplier;
      switch (timespan) {
        case Constants.portfolioChartTimespanDay:
          trendMultiplier = 0.01; // 1% over a day
          break;
        case Constants.portfolioChartTimespanWeek:
          trendMultiplier = 0.02; // 2% over a week
          break;
        case Constants.portfolioChartTimespanMonth:
          trendMultiplier = 0.03; // 3% over a month
          break;
        case Constants.portfolioChartTimespanThreeMonths:
          trendMultiplier = 0.04; // 4% over 3 months
          break;
        case Constants.portfolioChartTimespanYear:
          trendMultiplier = 0.08; // 8% over a year
          break;
        case Constants.portfolioChartTimespanFiveYears:
          trendMultiplier = 0.25; // 25% over 5 years
          break;
        default:
          trendMultiplier = 0.03;
      }

      final trendAmount = baseAmount * (1.0 + progress * trendMultiplier);

      // Add small fluctuations (±0.5% to ±2% depending on timespan)
      double fluctuationRange;
      switch (timespan) {
        case Constants.portfolioChartTimespanDay:
          fluctuationRange = 0.005; // ±0.5% for hourly data
          break;
        case Constants.portfolioChartTimespanWeek:
        case Constants.portfolioChartTimespanMonth:
        case Constants.portfolioChartTimespanThreeMonths:
          fluctuationRange = 0.01; // ±1% for daily data
          break;
        case Constants.portfolioChartTimespanYear:
          fluctuationRange = 0.015; // ±1.5% for weekly data
          break;
        case Constants.portfolioChartTimespanFiveYears:
          fluctuationRange = 0.02; // ±2% for monthly data
          break;
        default:
          fluctuationRange = 0.01;
      }

      // Use a simple pattern to create fluctuations (based on index to be deterministic)
      final fluctuation = (i % 7 - 3) * fluctuationRange * baseAmount;

      // Calculate new amount with trend and fluctuation
      // Use exponential smoothing to maintain continuity
      final targetAmount = trendAmount + fluctuation;
      currentAmount = currentAmount * 0.85 + targetAmount * 0.15;

      // Calculate performance percentage from base amount
      final performance = ((currentAmount - baseAmount) / baseAmount) * 100;

      // Calculate rate of return percentage (same as performance for this calculation)
      final rateOfReturnPercent = performance;

      // Calculate total profit or loss
      final totalProfitLoss = currentAmount - baseAmount;

      items.add(
        PortfolioChartItem()
          ..date = timestamp
          ..amount = currentAmount
          ..percentTimeWeightedCumulated = performance
          ..rateOfReturnPercent = rateOfReturnPercent
          ..totalProfitLoss = totalProfitLoss,
      );
    }

    return items;
  }
}

/// Creates a mock gRPC server for testing
class MockGrpcServer {
  Server? _server;
  int? _port;

  int get port => _port ?? 0;

  /// Start the mock server
  Future<void> start() async {
    final server = Server.create(
      services: [MockPortfolioChartService()],
      codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    );

    _server = server;
    // Serve on a random available port
    await server.serve(port: 0);
    _port = server.port; // Get the actual port the server is listening on
  }

  /// Stop the mock server
  Future<void> stop() async {
    await _server?.shutdown();
    _server = null;
    _port = null;
  }
}
