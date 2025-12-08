import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/bloc/bloc/portfolio_overview_bloc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_overview_data.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_overview_list.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/widgets/portfolio_overview_list_item.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/skeletonizer.dart';

@GenerateMocks([PortfolioOverviewBloc])
import 'portfolio_overview_list_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPortfolioOverviewBloc mockBloc;
  late StreamController<PortfolioOverviewState> stateController;

  setUp(() {
    mockBloc = MockPortfolioOverviewBloc();
    stateController = StreamController<PortfolioOverviewState>.broadcast();
    when(mockBloc.stream).thenAnswer((_) => stateController.stream);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      theme: AppTheme.getTheme(AppThemeMode.retailBank),
      home: BlocProvider<PortfolioOverviewBloc>.value(
        value: mockBloc,
        child: const Scaffold(
          body: PortfolioOverviewList(),
        ),
      ),
    );
  }

  final mockData = PortfolioOverviewData(
    items: [
      PortfolioWatchlistItem(
        name: 'Apple Inc.',
        symbol: 'AAPL',
        rateOfReturnPercent: 18.45,
        totalProfitLoss: 1845.50,
        totalInvestedAmount: 10000.0,
        shares: 50.0,
      ),
      PortfolioWatchlistItem(
        name: 'Microsoft Corporation',
        symbol: 'MSFT',
        rateOfReturnPercent: 22.30,
        totalProfitLoss: 2230.00,
        totalInvestedAmount: 10000.0,
        shares: 30.0,
      ),
    ],
  );

  group('PortfolioOverviewList', () {
    testWidgets('shows nothing in initial state', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.initial,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(PortfolioOverviewListItem), findsNothing);
      expect(find.byType(AppSkeletonizer), findsNothing);
    });

    testWidgets('shows loading skeleton in loading state', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.loading,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(AppSkeletonizer), findsOneWidget);

      // Check that skeletonizer is enabled
      final skeletonizer = tester.widget<AppSkeletonizer>(
        find.byType(AppSkeletonizer),
      );
      expect(skeletonizer.enabled, true);
    });

    testWidgets('displays list items when data is loaded', (tester) async {
      when(mockBloc.state).thenReturn(
        PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.success,
          data: mockData,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(PortfolioOverviewListItem), findsNWidgets(2));
    });

    testWidgets('displays empty state when no items', (tester) async {
      when(mockBloc.state).thenReturn(
        PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.success,
          data: PortfolioOverviewData(items: []),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('No portfolio items found'), findsOneWidget);
      expect(find.byType(PortfolioOverviewListItem), findsNothing);
    });

    testWidgets('displays error message and retry button in error state', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.error,
          error: 'Failed to load',
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Failed to load portfolio overview'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('retry button dispatches fetch event', (tester) async {
      when(mockBloc.state).thenReturn(
        const PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.error,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Retry'));
      await tester.pump();

      verify(
        mockBloc.add(
          const PortfolioOverviewEvent.fetchPortfolioOverview(),
        ),
      ).called(1);

      // Verify that no other event is dispatched
      verifyNever(
        mockBloc.add(any),
      );
    });

    testWidgets('displays correct item data', (tester) async {
      when(mockBloc.state).thenReturn(
        PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.success,
          data: PortfolioOverviewData(
            items: [
              PortfolioWatchlistItem(
                name: 'Tesla Inc.',
                symbol: 'TSLA',
                rateOfReturnPercent: 15.5,
                totalProfitLoss: 1550.0,
                totalInvestedAmount: 10000.0,
                shares: 25.0,
              ),
            ],
          ),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Tesla Inc.'), findsOneWidget);
      expect(find.text('TSLA'), findsOneWidget);
    });

    testWidgets('transitions from loading state to success state', (tester) async {
      // Start with loading state
      final loadingState = const PortfolioOverviewState(
        status: FetchPortfolioOverviewStatus.loading,
      );
      when(mockBloc.state).thenReturn(loadingState);

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump();

      expect(find.byType(AppSkeletonizer), findsOneWidget);

      // Transition to success state by emitting through stream
      final successState = PortfolioOverviewState(
        status: FetchPortfolioOverviewStatus.success,
        data: mockData,
      );
      when(mockBloc.state).thenReturn(successState);
      stateController.add(successState);
      await tester.pump();

      expect(find.byType(PortfolioOverviewListItem), findsNWidgets(2));
      expect(find.byType(AppSkeletonizer), findsNothing);
    });

    testWidgets('handles large list of items', (tester) async {
      final largeList = List.generate(
        20,
        (index) => PortfolioWatchlistItem(
          name: 'Company $index',
          symbol: 'SYM$index',
          rateOfReturnPercent: 10.0 + index,
          totalProfitLoss: 1000.0 * index,
          totalInvestedAmount: 10000.0,
          shares: 10.0 + index,
        ),
      );

      when(mockBloc.state).thenReturn(
        PortfolioOverviewState(
          status: FetchPortfolioOverviewStatus.success,
          data: PortfolioOverviewData(items: largeList),
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      // ListView.builder only renders visible items, so we check for at least some items
      expect(find.byType(PortfolioOverviewListItem), findsWidgets);
      // Verify first item is visible
      expect(find.text('Company 0'), findsOneWidget);
    });
  });
}
