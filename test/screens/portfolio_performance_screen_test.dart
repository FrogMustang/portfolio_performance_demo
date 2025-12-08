import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_overview_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_performance_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_timespan.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_overview_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/portfolio_performance_screen.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/chart_widget.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_overview_list.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_overview_list_item.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/theme/theme_bloc.dart';

// Generate mocks
@GenerateMocks([PortfolioPerformanceBloc, PortfolioOverviewBloc, ThemeBloc])
import 'portfolio_performance_screen_test.mocks.dart';

void main() {
  group('PortfolioPerformanceScreen', () {
    late MockPortfolioPerformanceBloc mockPerformanceBloc;
    late MockPortfolioOverviewBloc mockOverviewBloc;
    late MockThemeBloc mockThemeBloc;

    setUp(() {
      mockPerformanceBloc = MockPortfolioPerformanceBloc();
      mockOverviewBloc = MockPortfolioOverviewBloc();
      mockThemeBloc = MockThemeBloc();

      // Setup default state
      when(mockPerformanceBloc.state).thenReturn(
        const PortfolioPerformanceState(
          fetchPortfolioChartStatus: FetchPortfolioChartStatus.initial,
          timespan: PortfolioChartTimespan.day,
        ),
      );

      when(mockOverviewBloc.state).thenReturn(
        const PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.initial,
        ),
      );

      // Setup mock theme bloc with mock theme data to avoid Google Fonts loading
      when(mockThemeBloc.state).thenReturn(
        ThemeState(
          themeMode: AppThemeMode.retailBank,
          themeData: ThemeData.light(),
        ),
      );

      // BlocBuilder subscribes to the stream, so we need to provide a stream
      // that emits the current state. We can use a simple stream that emits once.
      when(mockPerformanceBloc.stream).thenAnswer(
        (_) => Stream.value(
          const PortfolioPerformanceState(
            fetchPortfolioChartStatus: FetchPortfolioChartStatus.initial,
            timespan: PortfolioChartTimespan.day,
          ),
        ),
      );

      when(mockOverviewBloc.stream).thenAnswer(
        (_) => Stream.value(
          const PortfolioOverviewState(
            status: FetchPortfolioOverviewStatus.initial,
          ),
        ),
      );

      when(mockThemeBloc.stream).thenAnswer(
        (_) => Stream.value(
          ThemeState(
            themeMode: AppThemeMode.retailBank,
            themeData: ThemeData.light(),
          ),
        ),
      );
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        theme: AppTheme.getTheme(AppThemeMode.retailBank),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PortfolioPerformanceBloc>.value(
              value: mockPerformanceBloc,
            ),
            BlocProvider<PortfolioOverviewBloc>.value(
              value: mockOverviewBloc,
            ),
            BlocProvider<ThemeBloc>.value(
              value: mockThemeBloc,
            ),
          ],
          child: const PortfolioPerformanceScreen(),
        ),
      );
    }

    testWidgets('displays Portfolio title', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Portfolio'), findsOneWidget);
      expect(find.text('Performance'), findsOneWidget);
    });

    testWidgets('displays header buttons', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.arrow_back_outlined), findsOneWidget);
      expect(find.byIcon(Icons.search_rounded), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
    });

    testWidgets('triggers fetch events on init', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      verify(
        mockPerformanceBloc.add(
          const PortfolioPerformanceEvent.fetchPortfolioChart(
            timespan: PortfolioChartTimespan.day,
          ),
        ),
      ).called(1);

      verify(
        mockOverviewBloc.add(
          const PortfolioOverviewEvent.fetchPortfolioOverview(),
        ),
      ).called(1);
    });

    testWidgets('displays chart when data is loaded', (tester) async {
      final now = DateTime.now();
      final mockData = PortfolioChartData(
        items: [
          PortfolioChartItem(
            date: now.subtract(const Duration(hours: 1)),
            amount: 100000.0,
            percentTimeWeightedCumulated: 5.0,
            rateOfReturnPercent: 5.0,
            totalProfitLoss: 5000.0,
          ),
        ],
      );

      final successState = PortfolioPerformanceState(
        fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
        timespan: PortfolioChartTimespan.day,
        portfolioChartData: mockData,
      );

      when(mockPerformanceBloc.state).thenReturn(successState);
      when(mockPerformanceBloc.stream).thenAnswer((_) => Stream.value(successState));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(ChartWidget), findsOneWidget);
    });

    testWidgets('displays overview list when data is loaded', (tester) async {
      final mockOverviewData = PortfolioOverviewData(
        items: [
          PortfolioWatchlistItem(
            name: 'Apple Inc.',
            symbol: 'AAPL',
            rateOfReturnPercent: 18.45,
            totalProfitLoss: 1845.50,
            totalInvestedAmount: 10000.0,
            shares: 50.0,
          ),
        ],
      );

      final successState = PortfolioOverviewState(
        status: FetchPortfolioOverviewStatus.success,
        data: mockOverviewData,
      );

      when(mockOverviewBloc.state).thenReturn(successState);
      when(mockOverviewBloc.stream).thenAnswer((_) => Stream.value(successState));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.text('Investments'), findsOneWidget);
      expect(find.byType(PortfolioOverviewList), findsOneWidget);
      expect(find.byType(PortfolioOverviewListItem), findsNWidgets(1));
      expect(find.text('Apple Inc.'), findsOneWidget);
      expect(find.text('AAPL'), findsOneWidget);
      expect(find.text('(+18.45%)'), findsOneWidget);
      expect(find.text('+1,845.50'), findsOneWidget);
      expect(find.text('10,000.00'), findsOneWidget);
      expect(find.text('50.00 shares'), findsOneWidget);
    });

    testWidgets('timespan dropdown shows correct value', (tester) async {
      const monthState = PortfolioPerformanceState(
        fetchPortfolioChartStatus: FetchPortfolioChartStatus.success,
        timespan: PortfolioChartTimespan.month,
      );

      when(mockPerformanceBloc.state).thenReturn(monthState);
      when(mockPerformanceBloc.stream).thenAnswer((_) => Stream.value(monthState));

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.text('1M'), findsOneWidget);
    });
  });
}
