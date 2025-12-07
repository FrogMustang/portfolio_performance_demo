import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_overview_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/portfolio_overview_repository.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';

part 'portfolio_overview_event.dart';
part 'portfolio_overview_state.dart';
part 'portfolio_overview_bloc.freezed.dart';

class PortfolioOverviewBloc extends Bloc<PortfolioOverviewEvent, PortfolioOverviewState> {
  final IPortfolioOverviewRepository repository;

  PortfolioOverviewBloc({required this.repository})
    : super(const PortfolioOverviewState()) {
    on<_FetchPortfolioOverview>(_onFetchPortfolioOverview);
  }

  Future<void> _onFetchPortfolioOverview(
    _FetchPortfolioOverview event,
    Emitter<PortfolioOverviewState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: FetchPortfolioOverviewStatus.loading,
        ),
      );

      final portfolioOverviewData = await repository.getPortfolioOverview();

      // throw Exception('Failed to fetch portfolio overview');

      emit(
        state.copyWith(
          data: portfolioOverviewData,
          status: FetchPortfolioOverviewStatus.success,
        ),
      );
    } catch (error, stackTrace) {
      logger.e(
        'Failed to fetch portfolio overview',
        error: error,
        stackTrace: stackTrace,
      );

      emit(
        state.copyWith(
          error: 'Failed to fetch portfolio overview data',
          status: FetchPortfolioOverviewStatus.error,
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
