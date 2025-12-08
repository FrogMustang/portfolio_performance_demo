import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/generated/portfolio_overview.pbgrpc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_api.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_repository.dart';

// Generate mocks
@GenerateMocks([IPortfolioOverviewApi])
import 'portfolio_overview_repository_test.mocks.dart';

void main() {
  group('PortfolioOverviewRepository', () {
    late MockIPortfolioOverviewApi mockApi;
    late PortfolioOverviewRepository repository;

    setUp(() {
      mockApi = MockIPortfolioOverviewApi();
      repository = PortfolioOverviewRepository(api: mockApi);
    });

    tearDown(() async {
      await repository.dispose();
    });

    test('getPortfolioOverview returns data from API', () async {
      final mockResponse = PortfolioOverviewResponse(
        items: [
          PortfolioWatchlistItem()
            ..name = 'Apple Inc.'
            ..symbol = 'AAPL'
            ..rateOfReturnPercent = 18.45
            ..totalProfitLoss = 1845.50
            ..totalInvestedAmount = 10000.0
            ..shares = 50.0,
          PortfolioWatchlistItem()
            ..name = 'Microsoft Corporation'
            ..symbol = 'MSFT'
            ..rateOfReturnPercent = 22.30
            ..totalProfitLoss = 2230.00
            ..totalInvestedAmount = 10000.0
            ..shares = 30.0,
        ],
      );

      when(mockApi.getPortfolioOverview()).thenAnswer((_) async => mockResponse);

      final result = await repository.getPortfolioOverview();

      expect(result.items.length, 2);
      expect(result.items[0].name, 'Apple Inc.');
      expect(result.items[0].symbol, 'AAPL');
      expect(result.items[0].rateOfReturnPercent, 18.45);
      expect(result.items[0].totalProfitLoss, 1845.50);
      expect(result.items[1].name, 'Microsoft Corporation');
      expect(result.items[1].symbol, 'MSFT');

      verify(mockApi.getPortfolioOverview()).called(1);
    });

    test('getPortfolioOverview handles empty response', () async {
      final mockResponse = PortfolioOverviewResponse(items: []);

      when(mockApi.getPortfolioOverview()).thenAnswer((_) async => mockResponse);

      final result = await repository.getPortfolioOverview();

      expect(result.items, isEmpty);
      verify(mockApi.getPortfolioOverview()).called(1);
    });

    test('getPortfolioOverview throws exception on API error', () async {
      when(mockApi.getPortfolioOverview()).thenThrow(Exception('Network error'));

      expect(
        () => repository.getPortfolioOverview(),
        throwsA(isA<Exception>()),
      );
    });

    test('dispose closes the API connection', () async {
      when(mockApi.close()).thenAnswer((_) async {});

      await repository.dispose();

      verify(mockApi.close()).called(1);
    });

    test('getPortfolioOverview converts proto data correctly', () async {
      final mockResponse = PortfolioOverviewResponse(
        items: [
          PortfolioWatchlistItem()
            ..name = 'Test Stock'
            ..symbol = 'TEST'
            ..rateOfReturnPercent = 15.0
            ..totalProfitLoss = 1500.0
            ..totalInvestedAmount = 10000.0
            ..shares = 100.0,
        ],
      );

      when(mockApi.getPortfolioOverview()).thenAnswer((_) async => mockResponse);

      final result = await repository.getPortfolioOverview();

      expect(result.items[0].name, 'Test Stock');
      expect(result.items[0].symbol, 'TEST');
      expect(result.items[0].rateOfReturnPercent, 15.0);
      expect(result.items[0].totalProfitLoss, 1500.0);
      expect(result.items[0].totalInvestedAmount, 10000.0);
      expect(result.items[0].shares, 100.0);
    });
  });

  group('PortfolioOverviewApi Factory', () {
    test('throws StateError when useMockData is true but server not initialized', () {
      // Ensure mock server is not initialized
      expect(
        () => PortfolioOverviewApi(
          host: 'localhost',
          port: 50051,
          useMockData: true,
        ),
        throwsStateError,
      );
    });

    test('creates API with secure credentials by default', () {
      final api = PortfolioOverviewApi(
        host: 'example.com',
        port: 443,
        secure: true,
      );

      expect(api, isNotNull);
      expect(api, isA<PortfolioOverviewApi>());
    });

    test('creates API with insecure credentials when secure is false', () {
      final api = PortfolioOverviewApi(
        host: 'localhost',
        port: 50051,
        secure: false,
      );

      expect(api, isNotNull);
      expect(api, isA<PortfolioOverviewApi>());
    });

    test('creates API with custom host and port', () {
      final api = PortfolioOverviewApi(
        host: 'custom.server.com',
        port: 9090,
        secure: true,
      );

      expect(api, isNotNull);
      expect(api, isA<PortfolioOverviewApi>());
    });

    test('creates API with insecure connection for local development', () {
      final api = PortfolioOverviewApi(
        host: '127.0.0.1',
        port: 8080,
        secure: false,
      );

      expect(api, isNotNull);
      expect(api, isA<PortfolioOverviewApi>());
    });
  });

  group('Integration Tests with Mock Server', () {
    setUp(() async {
      // Initialize mock server before each test
      await PortfolioOverviewApi.initializeMockServer();
    });

    tearDown(() async {
      // Clean up after each test
      await PortfolioOverviewApi.stopMockServer();
    });

    test('repository fetches data from mock gRPC server', () async {
      final api = PortfolioOverviewApi(
        host: 'localhost',
        port: 50051,
        useMockData: true,
      );
      final repository = PortfolioOverviewRepository(api: api);

      try {
        final result = await repository.getPortfolioOverview();

        expect(result.items.isNotEmpty, true);
        expect(result.items.length, 10); // Mock server returns 10 items
        expect(result.items[0].name, isNotEmpty);
        expect(result.items[0].symbol, isNotEmpty);
        expect(result.items[0].totalInvestedAmount, greaterThan(0));
      } finally {
        await repository.dispose();
      }
    });

    test('repository data contains valid stock information', () async {
      final api = PortfolioOverviewApi(
        host: 'localhost',
        port: 50051,
        useMockData: true,
      );
      final repository = PortfolioOverviewRepository(api: api);

      try {
        final result = await repository.getPortfolioOverview();

        for (final item in result.items) {
          expect(item.name, isNotEmpty);
          expect(item.symbol, isNotEmpty);
          expect(item.totalInvestedAmount, greaterThan(0));
          expect(item.shares, greaterThan(0));
        }
      } finally {
        await repository.dispose();
      }
    });
  });
}
