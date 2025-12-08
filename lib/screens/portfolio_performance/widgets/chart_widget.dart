import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_date_tooltip.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_details_card.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';

class ChartWidget extends StatefulWidget {
  final List<PortfolioChartItem> data;
  final List<TouchedSpotIndicatorData?> Function(
    LineChartBarData barData,
    List<int> spotIndexes,
  )?
  getTouchedSpotIndicator;
  final SideTitles? Function()? getBottomTitlesWidget;
  final String Function(double value) formatRightTitles;
  final int rightTitlesIntervalCount;

  const ChartWidget({
    super.key,
    required this.data,
    this.getTouchedSpotIndicator,
    this.getBottomTitlesWidget,
    required this.formatRightTitles,
    this.rightTitlesIntervalCount = 4,
  });

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  int? touchedIndex;
  bool isActivelyTouching = false;

  @override
  void initState() {
    super.initState();
    _initializeTouchedIndex();
  }

  @override
  void didUpdateWidget(ChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _initializeTouchedIndex();
    }
  }

  void _initializeTouchedIndex() {
    if (widget.data.isNotEmpty) {
      setState(() {
        touchedIndex = widget.data.length - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    if (widget.data.isEmpty) {
      return const SizedBox(height: 400, child: Center(child: Text('No data')));
    }

    final spots = widget.data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.amount);
    }).toList();

    final minY = widget.data.map((e) => e.amount).reduce((a, b) => a < b ? a : b);
    final maxY = widget.data.map((e) => e.amount).reduce((a, b) => a > b ? a : b);

    // Add padding to Y-axis to make spikes less prominent and center the line
    final range = maxY - minY;
    final padding = range > 0 ? range * 0.3 : maxY * 0.2;
    final paddedMinY = minY - padding;
    final paddedMaxY = maxY + padding;

    return SizedBox(
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with details
          if (touchedIndex != null && touchedIndex! < widget.data.length)
            BlocBuilder<PortfolioPerformanceBloc, PortfolioPerformanceState>(
              builder: (context, state) {
                return ChartDetailsWidget(
                  point: widget.data[touchedIndex!],
                  timespan: state.timespan,
                );
              },
            ),
          const SizedBox(height: 50),

          // Chart
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Chart Area
                  LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: widget.data.length.toDouble() - 1,
                      minY: paddedMinY,
                      maxY: paddedMaxY,
                      lineTouchData: LineTouchData(
                        enabled: true,
                        touchCallback: (FlTouchEvent event, LineTouchResponse? response) {
                          if (event is FlPanDownEvent ||
                              (event is FlPanUpdateEvent && response != null)) {
                            if (response != null &&
                                response.lineBarSpots != null &&
                                response.lineBarSpots!.isNotEmpty) {
                              setState(() {
                                isActivelyTouching = true;
                                touchedIndex = response.lineBarSpots!.first.spotIndex;
                              });
                            }
                          } else if (event is FlPanEndEvent ||
                              event is FlPanCancelEvent ||
                              event is FlTapUpEvent ||
                              event is FlTapCancelEvent) {
                            setState(() {
                              isActivelyTouching = false;

                              // Reset to last item when touch is released
                              if (widget.data.isNotEmpty) {
                                touchedIndex = widget.data.length - 1;
                              }
                            });
                          }
                        },
                        getTouchedSpotIndicator:
                            (LineChartBarData barData, List<int> spotIndexes) {
                              return widget.getTouchedSpotIndicator?.call(
                                    barData,
                                    spotIndexes,
                                  ) ??
                                  spotIndexes.map((index) {
                                    return TouchedSpotIndicatorData(
                                      FlLine(
                                        color: colors.primaryAccent,
                                        strokeWidth: 2,
                                        dashArray: [5, 5],
                                      ),
                                      FlDotData(
                                        show: true,
                                        getDotPainter: (spot, percent, barData, index) {
                                          return FlDotCirclePainter(
                                            radius: 6,
                                            color: colors.primaryAccent,
                                            strokeWidth: 3,
                                            strokeColor: colors.cardBackground,
                                          );
                                        },
                                      ),
                                    );
                                  }).toList();
                            },
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (touchedSpot) => Colors.transparent,
                          tooltipPadding: EdgeInsets.zero,
                          tooltipMargin: 0,
                          getTooltipItems: (touchedSpots) {
                            // Hide default tooltip - show custom one at the top of the chart
                            return touchedSpots.map((spot) => null).toList();
                          },
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval:
                            (paddedMaxY - paddedMinY) / widget.rightTitlesIntervalCount,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: colors.dividerColor.withValues(alpha: 0.5),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval:
                                (paddedMaxY - paddedMinY) /
                                widget.rightTitlesIntervalCount,
                            getTitlesWidget: (value, meta) {
                              // Calculate the Y position of this label in pixels
                              // For right-side labels, Y position calculation is the same as left-side
                              final chartHeight = meta.max - meta.min;
                              final valueRange = paddedMaxY - paddedMinY;
                              final valuePosition = value - paddedMinY;
                              final normalizedPosition = valuePosition / valueRange;
                              final yPosition =
                                  meta.max - normalizedPosition * chartHeight;

                              // Minimum spacing between labels (in pixels)
                              // Text height is approximately 14-16px, add padding for safe spacing
                              const minSpacing = 32.0;

                              // Margins from top and bottom edges
                              // These margins ensure labels don't overlap with chart boundaries
                              const edgeMargin = 12.0;

                              // Check if label is too close to top edge
                              if (yPosition < meta.min + edgeMargin) {
                                return const SizedBox.shrink();
                              }

                              // Check if label is too close to bottom edge
                              if (yPosition > meta.max - edgeMargin) {
                                return const SizedBox.shrink();
                              }

                              // Check spacing relative to other labels
                              // Calculate expected positions for all labels based on interval
                              final interval =
                                  (paddedMaxY - paddedMinY) /
                                  widget.rightTitlesIntervalCount;
                              final labelIndex = ((value - paddedMinY) / interval)
                                  .round();

                              // Check if this label would be too close to the previous label
                              if (labelIndex > 0) {
                                final prevLabelValue =
                                    paddedMinY + (labelIndex - 1) * interval;
                                final prevNormalized =
                                    (prevLabelValue - paddedMinY) / valueRange;
                                final prevYPosition =
                                    meta.max - prevNormalized * chartHeight;
                                if ((yPosition - prevYPosition).abs() < minSpacing) {
                                  return const SizedBox.shrink();
                                }
                              }

                              // Check if this label would be too close to the next label
                              if (labelIndex < widget.rightTitlesIntervalCount) {
                                final nextLabelValue =
                                    paddedMinY + (labelIndex + 1) * interval;
                                final nextNormalized =
                                    (nextLabelValue - paddedMinY) / valueRange;
                                final nextYPosition =
                                    meta.max - nextNormalized * chartHeight;
                                if ((nextYPosition - yPosition).abs() < minSpacing) {
                                  return const SizedBox.shrink();
                                }
                              }

                              // Right-aligned text for right-side labels
                              return Text(
                                widget.formatRightTitles(value),
                                style: textStyles.labelSmall,
                                textAlign: TextAlign.right,
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles:
                              widget.getBottomTitlesWidget?.call() ??
                              const SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          curveSmoothness: 0.3,
                          color: colors.primaryAccent,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                colors.primaryAccent.withValues(alpha: 0.3),
                                colors.primaryAccent.withValues(alpha: 0.05),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Date tooltip at the top of the touch indicator
                  if (isActivelyTouching &&
                      touchedIndex != null &&
                      touchedIndex! < widget.data.length)
                    Positioned(
                      left: () {
                        // Calculate the touch point X position
                        final touchPointX =
                            touchedIndex! *
                            (MediaQuery.of(context).size.width - 80) /
                            widget.data.length;

                        // Estimate tooltip width (date format "E, d MMM HH:mm" with padding)
                        // Roughly 150px
                        const estimatedTooltipWidth = 150.0;

                        // Center the tooltip on the touch point
                        var tooltipLeft = touchPointX - (estimatedTooltipWidth / 2);

                        // Clamp to ensure tooltip stays within screen bounds
                        final screenWidth = MediaQuery.of(context).size.width;
                        tooltipLeft = tooltipLeft.clamp(
                          0,
                          screenWidth - estimatedTooltipWidth,
                        );

                        return tooltipLeft;
                      }(),
                      top: -50, // Position above the chart
                      child: ChartDateTooltip(point: widget.data[touchedIndex!]),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
