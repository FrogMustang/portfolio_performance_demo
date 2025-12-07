import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/generated/google/protobuf/timestamp.pb.dart'
    as timestamp_pb;
import 'package:portfolio_performance_demo/generated/portfolio_chart.pbgrpc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_api.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_repository.dart';

// Generate mocks
@GenerateMocks([IPortfolioChartApi])
import 'portfolio_chart_repository_test.mocks.dart';

void main() {
  group('PortfolioChartRepository', () {
    late MockIPortfolioChartApi mockApi;
    late PortfolioChartRepository repository;

    setUp(() {
      mockApi = MockIPortfolioChartApi();
      repository = PortfolioChartRepository(api: mockApi);
    });

    tearDown(() async {
      await repository.dispose();
    });

    test('getPortfolioChart returns data from API', () async {
      final mockResponse = PortfolioChartResponse(
        items: [
          PortfolioChartItem(
            date: timestamp_pb.Timestamp.fromDateTime(
              DateTime(2021, 1, 1),
            ),
            amount: 100000.0,
            percentTimeWeightedCumulated: 5.5,
          ),
          PortfolioChartItem(
            date: timestamp_pb.Timestamp.fromDateTime(
              DateTime(2021, 1, 2),
            ),
            amount: 105000.0,
            percentTimeWeightedCumulated: 10.0,
          ),
        ],
      );

      when(
        mockApi.getPortfolioChart(timespan: anyNamed('timespan')),
      ).thenAnswer((_) async => mockResponse);

      final result = await repository.getPortfolioChart();

      expect(result.items.length, 2);
      expect(result.items[0].amount, 100000.0);
      expect(result.items[0].percentTimeWeightedCumulated, 5.5);
      expect(result.items[1].amount, 105000.0);
      expect(result.items[1].percentTimeWeightedCumulated, 10.0);

      verify(mockApi.getPortfolioChart(timespan: anyNamed('timespan'))).called(1);
    });

    test('getPortfolioChart passes timespan parameter', () async {
      final mockResponse = PortfolioChartResponse(items: []);

      when(
        mockApi.getPortfolioChart(timespan: 'week'),
      ).thenAnswer((_) async => mockResponse);

      await repository.getPortfolioChart(timespan: 'week');

      verify(mockApi.getPortfolioChart(timespan: 'week')).called(1);
    });

    test('getPortfolioChart converts proto timestamps correctly', () async {
      final testDateUtc = DateTime.utc(2021, 1, 1, 12, 30, 45);
      final timestamp = timestamp_pb.Timestamp.fromDateTime(testDateUtc);
      final mockResponse = PortfolioChartResponse(
        items: [
          PortfolioChartItem(
            date: timestamp,
            amount: 100000.0,
            percentTimeWeightedCumulated: 5.5,
          ),
        ],
      );

      when(
        mockApi.getPortfolioChart(timespan: anyNamed('timespan')),
      ).thenAnswer((_) async => mockResponse);

      final result = await repository.getPortfolioChart();

      // The model converts UTC to local time, so we expect the local equivalent
      final expectedLocalDate = testDateUtc.toLocal();
      expect(result.items[0].date, expectedLocalDate);

      // Also verify the underlying UTC time is the same
      expect(result.items[0].date.toUtc(), testDateUtc);
    });

    test('getPortfolioChart throws exception on API error', () async {
      when(
        mockApi.getPortfolioChart(timespan: anyNamed('timespan')),
      ).thenThrow(Exception('Network error'));

      expect(
        () => repository.getPortfolioChart(),
        throwsA(isA<Exception>()),
      );
    });

    test('dispose closes the API connection', () async {
      when(mockApi.close()).thenAnswer((_) async {});

      await repository.dispose();

      verify(mockApi.close()).called(1);
    });
  });

  group('PortfolioRepositoryFactory', () {
    group('PortfolioChartApi', () {
      tearDown(() async {
        // Clean up static mock server after each test
        await PortfolioChartApi.stopMockServer();
      });

      test('factory creates API with real server connection', () {
        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          secure: false,
          useMockData: false,
        );

        expect(api, isA<PortfolioChartApi>());
      });

      test('factory throws when useMockData is true but server not initialized', () {
        expect(
          () => PortfolioChartApi(
            host: 'localhost',
            port: 50051,
            useMockData: true,
          ),
          throwsA(isA<StateError>()),
        );
      });

      test('factory creates API with mock server when initialized', () async {
        await PortfolioChartApi.initializeMockServer();

        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );

        expect(api, isA<PortfolioChartApi>());

        await api.close();
      });

      test('initializeMockServer starts mock server', () async {
        await PortfolioChartApi.initializeMockServer();

        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );
        expect(api, isA<PortfolioChartApi>());

        await api.close();
      });

      test('initializeMockServer is idempotent', () async {
        await PortfolioChartApi.initializeMockServer();
        await PortfolioChartApi.initializeMockServer();

        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );
        expect(api, isA<PortfolioChartApi>());

        await api.close();
      });

      test('stopMockServer stops the mock server', () async {
        await PortfolioChartApi.initializeMockServer();

        await PortfolioChartApi.stopMockServer();

        expect(
          () => PortfolioChartApi(
            host: 'localhost',
            port: 50051,
            useMockData: true,
          ),
          throwsA(isA<StateError>()),
        );
      });

      test('API with mock server fetches data correctly', () async {
        await PortfolioChartApi.initializeMockServer();
        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );

        try {
          final result = await api.getPortfolioChart(timespan: 'month');

          expect(result.items.isNotEmpty, true);
          expect(result.items.length, 30);
          expect(result.items[0].amount, greaterThan(0));
        } finally {
          await api.close();
        }
      });

      test('API with mock server handles different timespans', () async {
        await PortfolioChartApi.initializeMockServer();
        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );

        try {
          final timespans = [
            'day',
            'week',
            'month',
            'three_months',
            'year',
            'five_years',
          ];

          for (final timespan in timespans) {
            final result = await api.getPortfolioChart(timespan: timespan);

            expect(
              result.items.isNotEmpty,
              true,
              reason: 'Timespan $timespan should return data',
            );
            expect(result.items[0].amount, greaterThan(0));
          }
        } finally {
          await api.close();
        }
      });
    });

    group('Integration Tests with Mock Server', () {
      setUp(() async {
        // Initialize mock server before each test
        await PortfolioChartApi.initializeMockServer();
      });

      tearDown(() async {
        // Clean up after each test
        await PortfolioChartApi.stopMockServer();
      });

      test('repository fetches data from mock gRPC server', () async {
        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );
        final repository = PortfolioChartRepository(api: api);

        try {
          final result = await repository.getPortfolioChart();

          expect(result.items.isNotEmpty, true);
          expect(result.items.length, 30);
          expect(result.items[0].amount, greaterThan(0));
          expect(result.items[0].date, isA<DateTime>());
        } finally {
          await repository.dispose();
        }
      });

      test('repository data is sorted chronologically', () async {
        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );
        final repository = PortfolioChartRepository(api: api);

        try {
          final result = await repository.getPortfolioChart();

          for (int i = 1; i < result.items.length; i++) {
            expect(
              result.items[i].date.isAfter(result.items[i - 1].date) ||
                  result.items[i].date.isAtSameMomentAs(result.items[i - 1].date),
              true,
              reason: 'Items should be sorted chronologically at index $i',
            );
          }
        } finally {
          await repository.dispose();
        }
      });

      test('repository handles different timespans correctly', () async {
        final api = PortfolioChartApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        );
        final repository = PortfolioChartRepository(api: api);

        try {
          final timespanTests = {
            'day': 24,
            'week': 7,
            'month': 30,
            'three_months': 90,
            'year': 52,
            'five_years': 60,
          };

          for (final entry in timespanTests.entries) {
            final result = await repository.getPortfolioChart(timespan: entry.key);

            expect(
              result.items.length,
              lessThanOrEqualTo(entry.value),
              reason: 'Timespan ${entry.key} should have at most ${entry.value} points',
            );
            expect(result.items.isNotEmpty, true);
          }
        } finally {
          await repository.dispose();
        }
      });
    });
  });
}
