import 'dart:async';
import 'package:grpc/grpc.dart';
import 'package:portfolio_performance_demo/generated/portfolio_chart.pbgrpc.dart';
import 'package:portfolio_performance_demo/generated/portfolio_overview.pbgrpc.dart';
import 'package:portfolio_performance_demo/generated/google/protobuf/timestamp.pb.dart'
    as timestamp_pb;
import 'package:portfolio_performance_demo/utils/constants.dart';

/// Creates a mock gRPC server for testing
class MockGrpcServer {
  Server? _server;
  int? _port;

  // Shared singleton instance
  static MockGrpcServer? _instance;

  int get port => _port ?? 0;

  MockGrpcServer._();

  /// Get the shared instance
  static MockGrpcServer get instance {
    _instance ??= MockGrpcServer._();
    return _instance!;
  }

  /// Start the mock server
  Future<void> start() async {
    if (_server != null && _port != null) {
      // Server already started
      return;
    }

    final server = Server.create(
      services: [
        MockPortfolioChartService(),
        MockPortfolioOverviewService(),
      ],
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
    _instance = null;
  }
}

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
      case Constants.portfolioChartTimespanDay: // 1D: Start from 24 hours ago
        startDate = now.subtract(const Duration(hours: 24));
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

/// Mock gRPC server implementation for portfolio overview
/// This simulates a real gRPC server and returns mock data
class MockPortfolioOverviewService extends PortfolioOverviewServiceBase {
  @override
  Future<PortfolioOverviewResponse> getPortfolioOverview(
    ServiceCall call,
    PortfolioOverviewRequest request,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final items = generateMockData();

    return PortfolioOverviewResponse(items: items);
  }

  static List<PortfolioWatchlistItem> generateMockData() {
    final List<PortfolioWatchlistItem> items = [];

    // Mock data for portfolio overview with popular stocks
    items.add(
      PortfolioWatchlistItem()
        ..name = 'Apple Inc.'
        ..symbol = 'AAPL'
        ..rateOfReturnPercent = 18.45
        ..totalProfitLoss = 1845.50
        ..totalInvestedAmount = 10000.0
        ..shares = 50.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Microsoft Corporation'
        ..symbol = 'MSFT'
        ..rateOfReturnPercent = 22.30
        ..totalProfitLoss = 2230.00
        ..totalInvestedAmount = 10000.0
        ..shares = 30.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Alphabet Inc.'
        ..symbol = 'GOOGL'
        ..rateOfReturnPercent = 15.67
        ..totalProfitLoss = 1567.00
        ..totalInvestedAmount = 10000.0
        ..shares = 80.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Amazon.com Inc.'
        ..symbol = 'AMZN'
        ..rateOfReturnPercent = 12.34
        ..totalProfitLoss = 1234.00
        ..totalInvestedAmount = 10000.0
        ..shares = 70.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Tesla, Inc.'
        ..symbol = 'TSLA'
        ..rateOfReturnPercent = 28.90
        ..totalProfitLoss = 2890.00
        ..totalInvestedAmount = 10000.0
        ..shares = 35.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'NVIDIA Corporation'
        ..symbol = 'NVDA'
        ..rateOfReturnPercent = 35.67
        ..totalProfitLoss = 3567.00
        ..totalInvestedAmount = 10000.0
        ..shares = 25.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Meta Platforms Inc.'
        ..symbol = 'META'
        ..rateOfReturnPercent = 19.23
        ..totalProfitLoss = 1923.00
        ..totalInvestedAmount = 10000.0
        ..shares = 40.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'JPMorgan Chase & Co.'
        ..symbol = 'JPM'
        ..rateOfReturnPercent = 8.45
        ..totalProfitLoss = 845.00
        ..totalInvestedAmount = 10000.0
        ..shares = 65.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Visa Inc.'
        ..symbol = 'V'
        ..rateOfReturnPercent = 14.56
        ..totalProfitLoss = 1456.00
        ..totalInvestedAmount = 10000.0
        ..shares = 45.0,
    );

    items.add(
      PortfolioWatchlistItem()
        ..name = 'Johnson & Johnson'
        ..symbol = 'JNJ'
        ..rateOfReturnPercent = 6.78
        ..totalProfitLoss = 678.00
        ..totalInvestedAmount = 10000.0
        ..shares = 60.0,
    );

    return items;
  }
}
