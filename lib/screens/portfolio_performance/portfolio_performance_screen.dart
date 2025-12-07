import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_chart.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';
import 'package:portfolio_performance_demo/widgets/app_icon_button.dart';
import 'package:portfolio_performance_demo/widgets/dropdown_button.dart';
import 'package:portfolio_performance_demo/widgets/quick_theme_switcher.dart';

class PortfolioPerformanceScreen extends StatefulWidget {
  const PortfolioPerformanceScreen({super.key});

  @override
  State<PortfolioPerformanceScreen> createState() => _PortfolioPerformanceScreenState();
}

class _PortfolioPerformanceScreenState extends State<PortfolioPerformanceScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PortfolioPerformanceBloc>().add(
      PortfolioPerformanceEvent.fetchPortfolioChart(
        timespan: PortfolioChartTimespan.day,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access custom colors and text styles using extensions
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              // HEADER BUTTONS
              Row(
                children: [
                  RoundIconButton(
                    onPressed: () {
                      Utils.showSnackbar(context, 'Back button pressed');
                    },
                    icon: Icons.arrow_back_outlined,
                  ),
                  Spacer(),

                  Row(
                    children: [
                      RoundIconButton(
                        onPressed: () {
                          Utils.showSnackbar(context, 'Back button pressed');
                        },
                        icon: Icons.search_rounded,
                      ),
                      const SizedBox(width: 16),

                      RoundIconButton(
                        onPressed: () {
                          Utils.showSnackbar(context, 'Search button pressed');
                        },
                        icon: Icons.notifications_outlined,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // SCROLLABLE CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      // HEADER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // HEADER TITLE
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Portfolio', style: textStyles.headlineLarge),
                              const SizedBox(height: 4),
                              Text(
                                'Performance',
                                style: textStyles.headlineSmall.copyWith(
                                  color: colors.primaryAccent,
                                ),
                              ),
                            ],
                          ),

                          // HEADER dropdown button
                          GradientDropdownButton(
                            selectedValue: context
                                .watch<PortfolioPerformanceBloc>()
                                .state
                                .timespan,
                            getDisplayText: (value) => value.displayName,
                            options: [
                              PortfolioChartTimespan.day,
                              PortfolioChartTimespan.week,
                              PortfolioChartTimespan.month,
                              PortfolioChartTimespan.threeMonths,
                              PortfolioChartTimespan.year,
                              PortfolioChartTimespan.fiveYears,
                            ],
                            onSelected: (value) {
                              context.read<PortfolioPerformanceBloc>().add(
                                PortfolioPerformanceEvent.fetchPortfolioChart(
                                  timespan: value,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Portfolio Chart
                      PortfolioChart(),
                      const SizedBox(height: 32),

                      // Transaction History
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Investments',
                            style: textStyles.titleLarge,
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: const QuickThemeSwitcher(),
    );
  }
}
