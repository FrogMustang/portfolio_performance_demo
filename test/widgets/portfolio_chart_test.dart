import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_chart.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_widget.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/app_icon_button.dart';
import 'package:portfolio_performance_demo/widgets/skeletonizer.dart';

@GenerateMocks([PortfolioPerformanceBloc])
import 'portfolio_chart_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPortfolioPerformanceBloc mockBloc;
  late StreamController<PortfolioPerformanceState> stateController;

  setUp(() {
    mockBloc = MockPortfolioPerformanceBloc();
    stateController = StreamController<PortfolioPerformanceState>.broadcast();
    when(mockBloc.stream).thenAnswer((_) => stateController.stream);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: AppTheme.getTheme(AppThemeMode.retailBank),
      home: BlocProvider<PortfolioPerformanceBloc>.value(
        value: mockBloc,
        child: const Scaffold(
          body: PortfolioChart(),
        ),
      ),
    );
  }

  final mockChartData = PortfolioChartData(
    items: [
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
    ],
  );

  group('PortfolioChart', () {
    testWidgets('renders add funds button', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.initial,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(RoundIconButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows loading skeleton in loading state', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.loading,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AppSkeletonizer), findsOneWidget);

      final skeletonizer = tester.widget<AppSkeletonizer>(
        find.byType(AppSkeletonizer),
      );
      expect(skeletonizer.enabled, true);
    });

    testWidgets('shows chart widget when data is loaded', (tester) async {
      when(mockBloc.state).thenReturn(
        PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
          timespan: PortfolioChartTimespan.day,
          portfolioChartData: mockChartData,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ChartWidget), findsOneWidget);
    });

    testWidgets('shows error message and retry button in error state', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Failed to fetch portfolio chart data'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('retry button dispatches fetch event with correct timespan', (
      tester,
    ) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.month,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          const PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.month,
          ),
        ),
      ).called(1);
    });

    testWidgets('shows loading skeleton in initial state', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.initial,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AppSkeletonizer), findsOneWidget);
    });

    testWidgets('shows loading skeleton then success state', (tester) async {
      // Test loading state
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.loading,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AppSkeletonizer), findsOneWidget);

      // Clean up and test success state
      await tester.pumpWidget(Container());
      await tester.pump();

      when(mockBloc.state).thenReturn(
        PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
          timespan: PortfolioChartTimespan.day,
          portfolioChartData: mockChartData,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ChartWidget), findsOneWidget);
    });

    testWidgets('retry button uses correct timespan for day', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.day,
          ),
        ),
      ).called(1);

      // Verify that no other timespan is fetched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('retry button uses correct timespan for week', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.week,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.week,
          ),
        ),
      ).called(1);

      // Verify that no other timespan is fetched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('retry button uses correct timespan for month', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.month,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.month,
          ),
        ),
      ).called(1);

      // Verify that no other timespan is fetched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('retry button uses correct timespan for three months', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.threeMonths,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.threeMonths,
          ),
        ),
      ).called(1);

      // Verify that no other timespan is fetched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('retry button uses correct timespan for year', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.year,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.year,
          ),
        ),
      ).called(1);

      // Verify that no other timespan is fetched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('retry button uses correct timespan for five years', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.error,
          timespan: PortfolioChartTimespan.fiveYears,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Try again'));
      await tester.pump();

      verify(
        mockBloc.add(
          PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.fiveYears,
          ),
        ),
      ).called(1);

      // Verify that no other timespan is fetched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('displays empty chart when data items are empty', (tester) async {
      when(mockBloc.state).thenReturn(
        PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
          timespan: PortfolioChartTimespan.day,
          portfolioChartData: PortfolioChartData(items: []),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(ChartWidget), findsOneWidget);
    });

    testWidgets('add funds button remains visible in all states', (tester) async {
      final states = [
        FetchPortfolioChartStatus.initial,
        FetchPortfolioChartStatus.loading,
        FetchPortfolioChartStatus.success,
        FetchPortfolioChartStatus.error,
      ];

      for (final status in states) {
        when(mockBloc.state).thenReturn(
          PortfolioPerformanceState(
            fetchPortfolioChartStatus: status,
            timespan: PortfolioChartTimespan.day,
            portfolioChartData: status == FetchPortfolioChartStatus.success
                ? mockChartData
                : null,
          ),
        );

        await tester.pumpWidget(createWidgetUnderTest());

        expect(
          find.byType(RoundIconButton),
          findsOneWidget,
          reason: 'Button should be visible in $status state',
        );
      }
    });

    testWidgets('add funds button is interactive in all states', (tester) async {
      final states = [
        FetchPortfolioChartStatus.initial,
        FetchPortfolioChartStatus.loading,
        FetchPortfolioChartStatus.success,
        FetchPortfolioChartStatus.error,
      ];

      for (final status in states) {
        when(mockBloc.state).thenReturn(
          PortfolioPerformanceState(
            fetchPortfolioChartStatus: status,
            timespan: PortfolioChartTimespan.day,
            portfolioChartData: status == FetchPortfolioChartStatus.success
                ? mockChartData
                : null,
          ),
        );

        await tester.pumpWidget(createWidgetUnderTest());

        // Tap the button
        await tester.tap(find.byType(RoundIconButton));
        await tester.pump();

        // Verify snackbar is shown in every state
        expect(
          find.byType(SnackBar),
          findsOneWidget,
          reason: 'Button should be interactive in $status state',
        );

        // Dismiss snackbar for next iteration
        await tester.pump(const Duration(seconds: 4));
      }
    });
  });
}
