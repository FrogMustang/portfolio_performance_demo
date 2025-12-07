import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_overview_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/mock_portfolio_grpc_server.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_overview_list_item.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';
import 'package:portfolio_performance_demo/widgets/skeletonizer.dart';

class PortfolioOverviewList extends StatelessWidget {
  const PortfolioOverviewList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortfolioOverviewBloc, PortfolioOverviewState>(
      builder: (context, state) {
        switch (state.status) {
          case FetchPortfolioOverviewStatus.loading:
            return _buildLoading(context);
          case FetchPortfolioOverviewStatus.error:
            return _buildError(context);
          case FetchPortfolioOverviewStatus.success:
            return _buildContent(context, items: state.data?.items ?? []);
          case FetchPortfolioOverviewStatus.initial:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required List<PortfolioWatchlistItem> items,
  }) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'No portfolio items found',
            style: textStyles.bodyMedium.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PortfolioOverviewListItem(
            item: items[index],
          ),
        );
      },
    );
  }

  Widget _buildLoading(BuildContext context) {
    return AppSkeletonizer(
      enabled: true,
      child: _buildContent(
        context,
        items: MockPortfolioOverviewService.generateMockData()
            .map(PortfolioWatchlistItem.fromProto)
            .toList(),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    final textStyles = context.textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Failed to load portfolio overview',
              style: textStyles.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<PortfolioOverviewBloc>().add(
                  const PortfolioOverviewEvent.fetchPortfolioOverview(),
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
