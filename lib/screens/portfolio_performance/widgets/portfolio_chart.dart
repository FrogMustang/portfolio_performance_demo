import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/mock_portfolio_grpc_server.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_widget.dart';
import 'package:portfolio_performance_demo/utils/amount_formatter.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';
import 'package:portfolio_performance_demo/widgets/app_icon_button.dart';
import 'package:portfolio_performance_demo/widgets/skeletonizer.dart';

class PortfolioChart extends StatefulWidget {
  const PortfolioChart({super.key});

  @override
  State<PortfolioChart> createState() => _PortfolioChartState();
}

class _PortfolioChartState extends State<PortfolioChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<PortfolioPerformanceBloc, PortfolioPerformanceState>(
          builder: (context, state) {
            switch (state.fetchPortfolioChartStatus) {
              case FetchPortfolioChartStatus.loading:
                return _buildLoading(state.timespan);
              case FetchPortfolioChartStatus.error:
                return _buildError(state.timespan);
              case FetchPortfolioChartStatus.success:
                return _buildContent(data: state.portfolioChartData?.items ?? []);
              default:
                return _buildLoading(state.timespan);
            }
          },
        ),

        Positioned(
          top: 16,
          right: 16,
          child: RoundIconButton(
            onPressed: () {
              Utils.showSnackbar(context, 'Add funds button pressed');
            },
            icon: Icons.add,
            isPrimary: true,
          ),
        ),
      ],
    );
  }

  Widget _buildContent({required List<PortfolioChartItem> data}) {
    return ChartWidget(
      data: data,
      formatRightTitles: AmountFormatter.formatAmountToKMB,
    );
  }

  Widget _buildLoading(PortfolioChartTimespan timespan) {
    return AppSkeletonizer(
      enabled: true,
      child: _buildContent(
        data: MockPortfolioChartService.generateMockData(
          timespan.name,
        ).map(PortfolioChartItem.fromProto).toList(),
      ),
    );
  }

  Widget _buildError(PortfolioChartTimespan timespan) {
    return SizedBox(
      height: 400,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Failed to fetch portfolio chart data'),

          // try again button
          ElevatedButton(
            onPressed: () {
              context.read<PortfolioPerformanceBloc>().add(
                PortfolioPerformanceEvent.fetchPortfolioChart(
                  timespan: timespan,
                ),
              );
            },
            child: Text('Try again'),
          ),
        ],
      ),
    );
  }
}
