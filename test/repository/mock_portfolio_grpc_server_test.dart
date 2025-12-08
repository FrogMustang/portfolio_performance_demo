import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/mock_portfolio_grpc_server.dart';
import 'package:portfolio_performance_demo/utils/constants.dart';

void main() {
  group('MockGrpcServer', () {
    late MockGrpcServer server;

    setUp(() {
      server = MockGrpcServer.instance;
    });

    tearDown(() async {
      await server.stop();
    });

    test('instance returns singleton', () {
      final instance1 = MockGrpcServer.instance;
      final instance2 = MockGrpcServer.instance;

      expect(instance1, equals(instance2));
    });

    test('start initializes server and assigns random port', () async {
      await server.start();

      expect(server.port, greaterThan(0));
    });

    test('starting server multiple times assigns the same port', () async {
      await server.start();
      final port1 = server.port;

      await server.start();
      final port2 = server.port;

      expect(port2, equals(port1));
    });

    test('stop shuts down server and resets port', () async {
      await server.start();
      expect(server.port, greaterThan(0));

      await server.stop();
      expect(server.port, 0);
    });

    test('port getter returns 0 when server not started', () {
      expect(server.port, 0);
    });
  });

  group('MockPortfolioChartService', () {
    test('generateMockData for day: all points within 24h and 1h intervals', () {
      final now = DateTime.now();
      final items = MockPortfolioChartService.generateMockData(
        Constants.portfolioChartTimespanDay,
      );

      expect(items.isNotEmpty, true);
      expect(items.length, lessThanOrEqualTo(Constants.portfolioChartMaxPointsDay));

      // Check that all points are within the past 24 hours
      final expectedStartDate = now.subtract(const Duration(hours: 24));
      final expectedEndDate = now;

      for (final item in items) {
        final date = item.date.toDateTime();
        expect(
          date.isAfter(expectedStartDate) || date.isAtSameMomentAs(expectedStartDate),
          true,
          reason: 'Date should be at or after start date (24h ago)',
        );
        expect(
          date.isBefore(expectedEndDate) || date.isAtSameMomentAs(expectedEndDate),
          true,
          reason: 'Date should be at or before now',
        );
      }

      // Check that consecutive points are approximately 1 hour apart
      for (int i = 1; i < items.length; i++) {
        final prevDate = items[i - 1].date.toDateTime();
        final currentDate = items[i].date.toDateTime();
        final difference = currentDate.difference(prevDate);

        expect(
          difference.inHours,
          equals(1),
          reason: 'Consecutive points should be 1 hour apart at index $i',
        );
        expect(
          difference.inMinutes,
          lessThanOrEqualTo(61), // Allow 1 minute tolerance
          reason: 'Sampling interval should be approximately 1 hour at index $i',
        );
      }
    });

    test('generateMockData for week: all points within 7 days and 1 day intervals', () {
      final now = DateTime.now();
      final items = MockPortfolioChartService.generateMockData(
        Constants.portfolioChartTimespanWeek,
      );

      expect(items.isNotEmpty, true);
      expect(items.length, lessThanOrEqualTo(Constants.portfolioChartMaxPointsWeek));

      // Check that all points are within the past 7 days
      final weekAgo = now.subtract(const Duration(days: 7));
      final expectedStartDate = DateTime(
        weekAgo.year,
        weekAgo.month,
        weekAgo.day,
        0,
        0,
        0,
      );

      for (final item in items) {
        final date = item.date.toDateTime();
        expect(
          date.isAfter(expectedStartDate) || date.isAtSameMomentAs(expectedStartDate),
          true,
          reason: 'Date should be at or after start date (7 days ago)',
        );
        expect(
          date.isBefore(now) || date.isAtSameMomentAs(now),
          true,
          reason: 'Date should be at or before now',
        );
      }

      // Check that consecutive points are approximately 1 day apart
      for (int i = 1; i < items.length; i++) {
        final prevDate = items[i - 1].date.toDateTime();
        final currentDate = items[i].date.toDateTime();
        final difference = currentDate.difference(prevDate);

        expect(
          difference.inDays,
          equals(1),
          reason: 'Consecutive points should be 1 day apart at index $i',
        );
      }
    });

    test('generateMockData for month: all points within 30 days and 1 day intervals', () {
      final now = DateTime.now();
      final items = MockPortfolioChartService.generateMockData(
        Constants.portfolioChartTimespanMonth,
      );

      expect(items.isNotEmpty, true);
      expect(items.length, lessThanOrEqualTo(Constants.portfolioChartMaxPointsMonth));

      // Check that all points are within the past 30 days
      final monthAgo = now.subtract(const Duration(days: 30));
      final expectedStartDate = DateTime(
        monthAgo.year,
        monthAgo.month,
        monthAgo.day,
        0,
        0,
        0,
      );

      for (final item in items) {
        final date = item.date.toDateTime();
        expect(
          date.isAfter(expectedStartDate) || date.isAtSameMomentAs(expectedStartDate),
          true,
          reason: 'Date should be at or after start date (30 days ago)',
        );
        expect(
          date.isBefore(now) || date.isAtSameMomentAs(now),
          true,
          reason: 'Date should be at or before now',
        );
      }

      // Check that consecutive points are approximately 1 day apart
      for (int i = 1; i < items.length; i++) {
        final prevDate = items[i - 1].date.toDateTime();
        final currentDate = items[i].date.toDateTime();
        final difference = currentDate.difference(prevDate);

        expect(
          difference.inDays,
          equals(1),
          reason: 'Consecutive points should be 1 day apart at index $i',
        );
      }
    });

    test(
      'generateMockData for three months: all points within 90 days and 1 day intervals',
      () {
        final now = DateTime.now();
        final items = MockPortfolioChartService.generateMockData(
          Constants.portfolioChartTimespanThreeMonths,
        );

        expect(items.isNotEmpty, true);
        expect(
          items.length,
          lessThanOrEqualTo(Constants.portfolioChartMaxPointsThreeMonths),
        );

        // Check that all points are within the past 90 days
        final threeMonthsAgo = now.subtract(const Duration(days: 90));
        final expectedStartDate = DateTime(
          threeMonthsAgo.year,
          threeMonthsAgo.month,
          threeMonthsAgo.day,
          0,
          0,
          0,
        );

        for (final item in items) {
          final date = item.date.toDateTime();

          expect(
            date.isAfter(expectedStartDate) || date.isAtSameMomentAs(expectedStartDate),
            true,
            reason: 'Date should be at or after start date (90 days ago)',
          );
          expect(
            date.isBefore(now) || date.isAtSameMomentAs(now),
            true,
            reason: 'Date should be at or before now',
          );
        }

        // Check that consecutive points are approximately 1 day apart
        for (int i = 1; i < items.length; i++) {
          final prevDate = items[i - 1].date.toDateTime();
          final currentDate = items[i].date.toDateTime();
          final difference = currentDate.difference(prevDate);

          expect(
            difference.inDays,
            equals(1),
            reason: 'Consecutive points should be 1 day apart at index $i',
          );
        }
      },
    );

    test('generateMockData for year: all points within 364 days and 7 day intervals', () {
      final now = DateTime.now();
      final items = MockPortfolioChartService.generateMockData(
        Constants.portfolioChartTimespanYear,
      );

      expect(items.isNotEmpty, true);
      expect(items.length, lessThanOrEqualTo(Constants.portfolioChartMaxPointsYear));

      // Check that all points are within the past 364 days (52 weeks)
      final yearAgo = now.subtract(const Duration(days: 364));
      final expectedStartDate = DateTime(
        yearAgo.year,
        yearAgo.month,
        yearAgo.day,
        0,
        0,
        0,
      );

      for (final item in items) {
        final date = item.date.toDateTime();

        expect(
          date.isAfter(expectedStartDate) || date.isAtSameMomentAs(expectedStartDate),
          true,
          reason: 'Date should be at or after start date (364 days ago)',
        );
        expect(
          date.isBefore(now) || date.isAtSameMomentAs(now),
          true,
          reason: 'Date should be at or before now',
        );
      }

      // Check that consecutive points are approximately 7 days apart
      for (int i = 1; i < items.length; i++) {
        final prevDate = items[i - 1].date.toDateTime();
        final currentDate = items[i].date.toDateTime();
        final difference = currentDate.difference(prevDate);

        expect(
          difference.inDays,
          equals(7),
          reason: 'Consecutive points should be 7 days apart at index $i',
        );
      }
    });

    test(
      'generateMockData for five years: all points within 1800 days and 30 day intervals',
      () {
        final now = DateTime.now();
        final items = MockPortfolioChartService.generateMockData(
          Constants.portfolioChartTimespanFiveYears,
        );

        expect(items.isNotEmpty, true);
        expect(
          items.length,
          lessThanOrEqualTo(Constants.portfolioChartMaxPointsFiveYears),
        );

        // Check that all points are within the past 1800 days (60 months)
        final fiveYearsAgo = now.subtract(const Duration(days: 1800));
        final expectedStartDate = DateTime(
          fiveYearsAgo.year,
          fiveYearsAgo.month,
          fiveYearsAgo.day,
          0,
          0,
          0,
        );

        for (final item in items) {
          final date = item.date.toDateTime();

          expect(
            date.isAfter(expectedStartDate) || date.isAtSameMomentAs(expectedStartDate),
            true,
            reason: 'Date should be at or after start date (1800 days ago)',
          );
          expect(
            date.isBefore(now) || date.isAtSameMomentAs(now),
            true,
            reason: 'Date should be at or before now',
          );
        }

        // Check that consecutive points are approximately 30 days apart
        for (int i = 1; i < items.length; i++) {
          final prevDate = items[i - 1].date.toDateTime();
          final currentDate = items[i].date.toDateTime();
          final difference = currentDate.difference(prevDate);

          expect(
            difference.inDays,
            equals(30),
            reason: 'Consecutive points should be 30 days apart at index $i',
          );
        }
      },
    );

    test('generateMockData returns data sorted chronologically', () {
      final items = MockPortfolioChartService.generateMockData(
        Constants.portfolioChartTimespanMonth,
      );

      for (int i = 1; i < items.length; i++) {
        final prevDate = items[i - 1].date.toDateTime();
        final currentDate = items[i].date.toDateTime();
        expect(
          currentDate.isAfter(prevDate) || currentDate.isAtSameMomentAs(prevDate),
          true,
          reason: 'Items should be sorted chronologically at index $i',
        );
      }
    });

    test('generateMockData handles empty/null timespan with default', () {
      final items1 = MockPortfolioChartService.generateMockData('');
      final items2 = MockPortfolioChartService.generateMockData(null);

      expect(items1.isNotEmpty, true);
      expect(items2.isNotEmpty, true);
      expect(items1.length, lessThanOrEqualTo(30)); // Default is month
      expect(items2.length, lessThanOrEqualTo(30));
    });

    test('generateMockData includes all required fields', () {
      final items = MockPortfolioChartService.generateMockData(
        Constants.portfolioChartTimespanWeek,
      );

      for (final item in items) {
        expect(item.hasDate(), true);
        expect(item.hasAmount(), true);
        expect(item.hasPercentTimeWeightedCumulated(), true);
        expect(item.hasRateOfReturnPercent(), true);
        expect(item.hasTotalProfitLoss(), true);
      }
    });
  });

  group('MockPortfolioOverviewService', () {
    test('generateMockData returns 10 stock items', () {
      final items = MockPortfolioOverviewService.generateMockData();

      expect(items.length, 10);
    });

    test('generateMockData returns items with all required fields', () {
      final items = MockPortfolioOverviewService.generateMockData();

      for (final item in items) {
        expect(item.hasName(), true);
        expect(item.hasSymbol(), true);
        expect(item.hasRateOfReturnPercent(), true);
        expect(item.hasTotalProfitLoss(), true);
        expect(item.hasTotalInvestedAmount(), true);
        expect(item.hasShares(), true);
      }
    });

    test('generateMockData returns items with positive investment amounts', () {
      final items = MockPortfolioOverviewService.generateMockData();

      for (final item in items) {
        expect(item.totalInvestedAmount, 10000.0);
        expect(item.shares, greaterThan(0));
      }
    });

    test('generateMockData is always the same', () {
      final items1 = MockPortfolioOverviewService.generateMockData();
      final items2 = MockPortfolioOverviewService.generateMockData();

      expect(items1.length, items2.length);
      for (int i = 0; i < items1.length; i++) {
        expect(items1[i].name, items2[i].name);
        expect(items1[i].symbol, items2[i].symbol);
        expect(items1[i].rateOfReturnPercent, items2[i].rateOfReturnPercent);
      }
    });
  });
}
