import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_repository.dart';

// Generate mocks
@GenerateMocks([IPortfolioChartRepository])
import 'portfolio_performance_bloc_test.mocks.dart';

void main() {
  group('PortfolioPerformanceBloc', () {
    late MockIPortfolioChartRepository mockRepository;
    late PortfolioPerformanceBloc bloc;

    setUp(() {
      mockRepository = MockIPortfolioChartRepository();
      bloc = PortfolioPerformanceBloc(repository: mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, const PortfolioPerformanceState());
      expect(bloc.state.fetchPortfolioChartStatus, FetchPortfolioChartStatus.initial);
      expect(bloc.state.portfolioChartData, isNull);
      expect(bloc.state.error, isNull);
    });

    group('FetchPortfolioChart', () {
      // Use DateTime.now() as base for mock data
      final now = DateTime.now();
      final mockData = PortfolioChartData(
        items: [
          PortfolioChartItem(
            date: now.subtract(const Duration(hours: 2)),
            amount: 100000.0,
            percentTimeWeightedCumulated: 5.0,
            rateOfReturnPercent: 5.0,
            totalProfitLoss: 5000.0,
          ),
          PortfolioChartItem(
            date: now.subtract(const Duration(hours: 1)),
            amount: 105000.0,
            percentTimeWeightedCumulated: 10.0,
            rateOfReturnPercent: 10.0,
            totalProfitLoss: 10000.0,
          ),
        ],
      );

      blocTest<PortfolioPerformanceBloc, PortfolioPerformanceState>(
        'emits [loading, success] when fetch succeeds',
        build: () {
          when(
            mockRepository.getPortfolioChart(timespan: anyNamed('timespan')),
          ).thenAnswer((_) async => mockData);
          return bloc;
        },
        act: (bloc) => bloc.add(
          const PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.month,
          ),
        ),
        expect: () => [
          const PortfolioPerformanceState(
            fetchPortfolioChartStatus: FetchPortfolioChartStatus.loading,
            timespan: PortfolioChartTimespan.month,
          ),
          PortfolioPerformanceState(
            fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
            timespan: PortfolioChartTimespan.month,
            portfolioChartData: mockData,
          ),
        ],
        verify: (_) {
          verify(mockRepository.getPortfolioChart(timespan: 'month')).called(1);
        },
      );

      blocTest<PortfolioPerformanceBloc, PortfolioPerformanceState>(
        'emits [loading, error] when fetch fails',
        build: () {
          when(
            mockRepository.getPortfolioChart(timespan: anyNamed('timespan')),
          ).thenThrow(Exception('Network error'));
          return bloc;
        },
        act: (bloc) => bloc.add(
          const PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.week,
          ),
        ),
        expect: () => [
          const PortfolioPerformanceState(
            fetchPortfolioChartStatus: FetchPortfolioChartStatus.loading,
            timespan: PortfolioChartTimespan.week,
          ),
          const PortfolioPerformanceState(
            fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
            timespan: PortfolioChartTimespan.week,
            error: 'Failed to fetch portfolio chart data',
          ),
        ],
      );

      blocTest<PortfolioPerformanceBloc, PortfolioPerformanceState>(
        'passes correct timespan to repository',
        build: () {
          when(
            mockRepository.getPortfolioChart(timespan: 'day'),
          ).thenAnswer((_) async => mockData);
          return bloc;
        },
        act: (bloc) => bloc.add(
          const PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.day,
          ),
        ),
        verify: (_) {
          verify(mockRepository.getPortfolioChart(timespan: 'day')).called(1);
        },
      );

      blocTest<PortfolioPerformanceBloc, PortfolioPerformanceState>(
        'handles all timespans correctly',
        build: () {
          when(
            mockRepository.getPortfolioChart(timespan: anyNamed('timespan')),
          ).thenAnswer((_) async => mockData);
          return bloc;
        },
        act: (bloc) async {
          bloc.add(
            const PortfolioPerformanceEvent.fetchPortfolioChart(
              timespan: PortfolioChartTimespan.day,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(
            const PortfolioPerformanceEvent.fetchPortfolioChart(
              timespan: PortfolioChartTimespan.week,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(
            const PortfolioPerformanceEvent.fetchPortfolioChart(
              timespan: PortfolioChartTimespan.threeMonths,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(
            const PortfolioPerformanceEvent.fetchPortfolioChart(
              timespan: PortfolioChartTimespan.year,
            ),
          );
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(
            const PortfolioPerformanceEvent.fetchPortfolioChart(
              timespan: PortfolioChartTimespan.fiveYears,
            ),
          );
        },
        verify: (_) {
          verify(mockRepository.getPortfolioChart(timespan: 'day')).called(1);
          verify(mockRepository.getPortfolioChart(timespan: 'week')).called(1);
          verify(mockRepository.getPortfolioChart(timespan: 'three_months')).called(1);
          verify(mockRepository.getPortfolioChart(timespan: 'year')).called(1);
          verify(mockRepository.getPortfolioChart(timespan: 'five_years')).called(1);
        },
      );
    });
  });
}
