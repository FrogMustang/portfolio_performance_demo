import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_overview_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_overview_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_repository.dart';

// Generate mocks
@GenerateMocks([IPortfolioOverviewRepository])
import 'portfolio_overview_bloc_test.mocks.dart';

void main() {
  group('PortfolioOverviewBloc', () {
    late MockIPortfolioOverviewRepository mockRepository;
    late PortfolioOverviewBloc bloc;

    setUp(() {
      mockRepository = MockIPortfolioOverviewRepository();
      bloc = PortfolioOverviewBloc(repository: mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    group('FetchPortfolioOverview', () {
      final mockData = PortfolioOverviewData(
        items: [
          PortfolioWatchlistItem(
            name: 'Apple Inc.',
            symbol: 'AAPL',
            rateOfReturnPercent: 18.45,
            totalProfitLoss: 1845.50,
            totalInvestedAmount: 10000.0,
            shares: 50.0,
          ),
          PortfolioWatchlistItem(
            name: 'Microsoft Corporation',
            symbol: 'MSFT',
            rateOfReturnPercent: 22.30,
            totalProfitLoss: 2230.00,
            totalInvestedAmount: 10000.0,
            shares: 30.0,
          ),
        ],
      );

      blocTest<PortfolioOverviewBloc, PortfolioOverviewState>(
        'emits [loading, success] when fetch succeeds',
        build: () {
          when(mockRepository.getPortfolioOverview()).thenAnswer((_) async => mockData);
          return bloc;
        },
        act: (bloc) => bloc.add(const PortfolioOverviewEvent.fetchPortfolioOverview()),
        verify: (bloc) {
          verify(mockRepository.getPortfolioOverview()).called(1);

          expect(bloc.state.status, FetchPortfolioOverviewStatus.success);
          expect(bloc.state.data?.items.length, 2);
          expect(bloc.state.error, isNull);
        },
      );

      blocTest<PortfolioOverviewBloc, PortfolioOverviewState>(
        'emits [loading, error] when fetch fails',
        build: () {
          when(
            mockRepository.getPortfolioOverview(),
          ).thenThrow(Exception('Network error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const PortfolioOverviewEvent.fetchPortfolioOverview()),
        verify: (bloc) {
          expect(bloc.state.status, FetchPortfolioOverviewStatus.error);
          expect(bloc.state.error, 'Failed to fetch portfolio overview data');
          expect(bloc.state.data, isNull);
        },
      );

      blocTest<PortfolioOverviewBloc, PortfolioOverviewState>(
        'handles empty data correctly',
        build: () {
          final emptyData = PortfolioOverviewData(items: []);
          when(mockRepository.getPortfolioOverview()).thenAnswer((_) async => emptyData);
          return bloc;
        },
        act: (bloc) => bloc.add(const PortfolioOverviewEvent.fetchPortfolioOverview()),
        verify: (bloc) {
          expect(bloc.state.status, FetchPortfolioOverviewStatus.success);
          expect(bloc.state.data, isNotNull);
          expect(bloc.state.data?.items, isEmpty);
          expect(bloc.state.error, isNull);
        },
      );

      blocTest<PortfolioOverviewBloc, PortfolioOverviewState>(
        'can handle multiple consecutive fetches',
        build: () {
          when(mockRepository.getPortfolioOverview()).thenAnswer((_) async => mockData);
          return bloc;
        },
        act: (bloc) async {
          bloc.add(const PortfolioOverviewEvent.fetchPortfolioOverview());
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(const PortfolioOverviewEvent.fetchPortfolioOverview());
        },
        verify: (_) {
          verify(mockRepository.getPortfolioOverview()).called(2);
        },
      );
    });
  });
}
