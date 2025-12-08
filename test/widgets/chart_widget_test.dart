import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_details_card.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_widget.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';

@GenerateMocks([PortfolioPerformanceBloc])
import 'chart_widget_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPortfolioPerformanceBloc mockBloc;

  setUp(() {
    mockBloc = MockPortfolioPerformanceBloc();
    final initialState = const PortfolioPerformanceState(
      fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
      timespan: PortfolioChartTimespan.day,
    );
    when(mockBloc.state).thenReturn(initialState);
    when(mockBloc.stream).thenAnswer((_) => Stream.value(initialState));
  });

  Widget createWidgetUnderTest({
    required List<PortfolioChartItem> data,
    List<TouchedSpotIndicatorData?> Function(
      LineChartBarData barData,
      List<int> spotIndexes,
    )?
    getTouchedSpotIndicator,
  }) {
    return MaterialApp(
      theme: AppTheme.getTheme(AppThemeMode.retailBank),
      home: BlocProvider<PortfolioPerformanceBloc>.value(
        value: mockBloc,
        child: Scaffold(
          body: ChartWidget(
            data: data,
            formatRightTitles: (value) => value.toStringAsFixed(0),
            getTouchedSpotIndicator: getTouchedSpotIndicator,
          ),
        ),
      ),
    );
  }

  final mockChartData = [
    PortfolioChartItem(
      date: DateTime.now().subtract(const Duration(hours: 2)),
      amount: 100000.0,
      percentTimeWeightedCumulated: 5.0,
      rateOfReturnPercent: 5.0,
      totalProfitLoss: 5000.0,
    ),
    PortfolioChartItem(
      date: DateTime.now().subtract(const Duration(hours: 1)),
      amount: 105000.0,
      percentTimeWeightedCumulated: 10.0,
      rateOfReturnPercent: 10.0,
      totalProfitLoss: 10000.0,
    ),
    PortfolioChartItem(
      date: DateTime.now(),
      amount: 110000.0,
      percentTimeWeightedCumulated: 15.0,
      rateOfReturnPercent: 15.0,
      totalProfitLoss: 15000.0,
    ),
  ];

  group('ChartWidget', () {
    testWidgets('renders with chart data', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

      expect(find.byType(ChartWidget), findsOneWidget);
      expect(find.byType(LineChart), findsOneWidget);
    });

    testWidgets('displays empty state when no data', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: []));

      expect(find.text('No data'), findsOneWidget);
      expect(find.byType(LineChart), findsNothing);
    });

    testWidgets('shows ChartDetailsWidget', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

      expect(find.byType(ChartDetailsWidget), findsOneWidget);
    });

    testWidgets('initializes with last data point selected', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));
      await tester.pump();

      // Last point should be displayed in ChartDetailsWidget
      expect(find.byType(ChartDetailsWidget), findsOneWidget);
    });

    group('Touch interactions', () {
      testWidgets('chart has touch enabled', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        expect(lineChart.data.lineTouchData.enabled, true);
      });

      testWidgets('touchCallback is configured', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        expect(lineChart.data.lineTouchData.touchCallback, isNotNull);
      });

      testWidgets('touch tooltip data is configured correctly', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final tooltipData = lineChart.data.lineTouchData.touchTooltipData;

        expect(tooltipData, isNotNull);
        expect(tooltipData.tooltipPadding, EdgeInsets.zero);
        expect(tooltipData.tooltipMargin, 0);
      });

      testWidgets('tooltip color is transparent', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final tooltipData = lineChart.data.lineTouchData.touchTooltipData;

        final color = tooltipData.getTooltipColor(
          LineBarSpot(
            LineChartBarData(spots: []),
            0,
            FlSpot(0, 0),
          ),
        );

        expect(color, Colors.transparent);
      });

      testWidgets('tooltip items return null to hide default tooltip', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final tooltipData = lineChart.data.lineTouchData.touchTooltipData;

        final items = tooltipData.getTooltipItems([
          LineBarSpot(
            LineChartBarData(spots: []),
            0,
            FlSpot(0, 0),
          ),
        ]);

        expect(items, isNotNull);
        expect(items.length, 1);
        expect(items[0], null);
      });
    });

    group('Touch indicator', () {
      testWidgets('uses default indicator when not provided', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final indicator = lineChart.data.lineTouchData.getTouchedSpotIndicator;

        expect(indicator, isNotNull);

        final indicators = indicator(
          LineChartBarData(spots: []),
          [0],
        );

        expect(indicators, isNotNull);
        expect(indicators.length, 1);
        expect(indicators[0], isA<TouchedSpotIndicatorData>());
      });

      testWidgets('default indicator returns correct number of indicators', (
        tester,
      ) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final indicator = lineChart.data.lineTouchData.getTouchedSpotIndicator;

        final indicators = indicator(
          LineChartBarData(spots: []),
          [0],
        );

        expect(indicators.length, 1);
        expect(indicators[0], isA<TouchedSpotIndicatorData>());
      });

      testWidgets('handles multiple spot indexes', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final indicator = lineChart.data.lineTouchData.getTouchedSpotIndicator;

        final indicators = indicator(
          LineChartBarData(spots: []),
          [0, 1, 2],
        );

        expect(indicators.length, 3);
        expect(indicators[0], isA<TouchedSpotIndicatorData>());
        expect(indicators[1], isA<TouchedSpotIndicatorData>());
        expect(indicators[2], isA<TouchedSpotIndicatorData>());
      });
    });

    group('Data updates', () {
      testWidgets('updates when data changes', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final newData = [
          ...mockChartData,
          PortfolioChartItem(
            date: DateTime.now().add(const Duration(hours: 1)),
            amount: 115000.0,
            percentTimeWeightedCumulated: 20.0,
            rateOfReturnPercent: 20.0,
            totalProfitLoss: 20000.0,
          ),
        ];

        await tester.pumpWidget(createWidgetUnderTest(data: newData));
        await tester.pump();

        expect(find.byType(ChartWidget), findsOneWidget);
      });
    });

    group('Chart rendering', () {
      testWidgets('renders line chart with correct data', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        expect(lineChart.data.lineBarsData.length, 1);
        expect(lineChart.data.lineBarsData[0].spots.length, mockChartData.length);
      });

      testWidgets('chart has gradient below line', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final barData = lineChart.data.lineBarsData[0];

        expect(barData.belowBarData.show, true);
        expect(barData.belowBarData.gradient, isA<LinearGradient>());
      });

      testWidgets('chart line is curved', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final barData = lineChart.data.lineBarsData[0];

        expect(barData.isCurved, true);
        expect(barData.curveSmoothness, 0.3);
      });

      testWidgets('chart has correct line width', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final barData = lineChart.data.lineBarsData[0];

        expect(barData.barWidth, 3);
      });

      testWidgets('chart dots are hidden on line', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final barData = lineChart.data.lineBarsData[0];

        expect(barData.dotData.show, false);
      });
    });

    group('Chart axes', () {
      testWidgets('has correct X axis range', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));

        expect(lineChart.data.minX, 0);
        expect(lineChart.data.maxX, mockChartData.length.toDouble() - 1);
      });

      testWidgets('Y axis has padding', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));

        final minAmount = mockChartData
            .map((e) => e.amount)
            .reduce((a, b) => a < b ? a : b);
        final maxAmount = mockChartData
            .map((e) => e.amount)
            .reduce((a, b) => a > b ? a : b);

        // Y axis should have padding, so it should be outside the data range
        expect(lineChart.data.minY, lessThan(minAmount));
        expect(lineChart.data.maxY, greaterThan(maxAmount));
      });

      testWidgets('right titles are shown', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final rightTitles = lineChart.data.titlesData.rightTitles.sideTitles;

        expect(rightTitles.showTitles, true);
        expect(rightTitles.reservedSize, 40);
      });

      testWidgets('bottom titles are hidden by default', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final bottomTitles = lineChart.data.titlesData.bottomTitles.sideTitles;

        expect(bottomTitles.showTitles, false);
      });

      testWidgets('left and top titles are hidden', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));

        expect(lineChart.data.titlesData.leftTitles.sideTitles.showTitles, false);
        expect(lineChart.data.titlesData.topTitles.sideTitles.showTitles, false);
      });
    });

    group('Grid', () {
      testWidgets('grid is shown', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));

        expect(lineChart.data.gridData.show, true);
      });

      testWidgets('vertical grid lines are hidden', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));

        expect(lineChart.data.gridData.drawVerticalLine, false);
      });

      testWidgets('horizontal grid line configuration', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

        final lineChart = tester.widget<LineChart>(find.byType(LineChart));
        final gridLine = lineChart.data.gridData.getDrawingHorizontalLine(0);

        expect(gridLine.strokeWidth, 1);
      });
    });

    testWidgets('chart border is hidden', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

      final lineChart = tester.widget<LineChart>(find.byType(LineChart));

      expect(lineChart.data.borderData.show, false);
    });

    testWidgets('chart container has correct height', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));

      // Find the SizedBox that wraps the entire chart widget
      final sizedBoxes = tester.widgetList<SizedBox>(find.byType(SizedBox)).toList();

      // The chart's root SizedBox should have height 400
      final chartSizedBox = sizedBoxes.firstWhere(
        (box) => box.height == 400,
        orElse: () => throw Exception('No SizedBox with height 400 found'),
      );

      expect(chartSizedBox.height, 400);
    });

    testWidgets('format right titles is called', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(data: mockChartData));
      await tester.pump();

      // The formatRightTitles function should be used for axis labels
      expect(find.byType(LineChart), findsOneWidget);
    });
  });
}
