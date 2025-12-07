import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_chart_repository.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';

part 'portfolio_performance_event.dart';
part 'portfolio_performance_state.dart';
part 'portfolio_performance_bloc.freezed.dart';

class PortfolioPerformanceBloc
    extends Bloc<PortfolioPerformanceEvent, PortfolioPerformanceState> {
  final IPortfolioChartRepository repository;

  PortfolioPerformanceBloc({required this.repository})
    : super(const PortfolioPerformanceState()) {
    on<_FetchPortfolioChart>(_onFetchPortfolioChart);
  }

  Future<void> _onFetchPortfolioChart(
    _FetchPortfolioChart event,
    Emitter<PortfolioPerformanceState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.loading,
          timespan: event.timespan,
        ),
      );

      final portfolioChartData = await repository.getPortfolioChart(
        timespan: event.timespan.name,
      );

      emit(
        state.copyWith(
          portfolioChartData: portfolioChartData,
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      logger.e(
        'Failed to fetch portfolio chart',
        error: error,
        stackTrace: stackTrace,
      );

      emit(
        state.copyWith(
          error: 'Failed to fetch portfolio chart data',
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await repository.dispose();
    return super.close();
  }
}
