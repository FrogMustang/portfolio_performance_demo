import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/theme/theme_bloc.dart';
import 'package:portfolio_performance_demo/widgets/quick_theme_switcher.dart';

@GenerateMocks([ThemeBloc])
import 'quick_theme_switcher_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockThemeBloc mockThemeBloc;
  late StreamController<ThemeState> stateController;

  setUp(() {
    mockThemeBloc = MockThemeBloc();
    stateController = StreamController<ThemeState>.broadcast();
    when(mockThemeBloc.stream).thenAnswer((_) => stateController.stream);
  });

  tearDown(() {
    stateController.close();
  });

  Widget createWidgetUnderTest(AppThemeMode themeMode) {
    final initialState = ThemeState(
      themeMode: themeMode,
      themeData: AppTheme.getTheme(themeMode),
    );
    when(mockThemeBloc.state).thenReturn(initialState);
    stateController.add(initialState);

    return MaterialApp(
      theme: AppTheme.getTheme(themeMode),
      home: BlocProvider<ThemeBloc>.value(
        value: mockThemeBloc,
        child: const Scaffold(
          body: Center(
            child: QuickThemeSwitcher(),
          ),
        ),
      ),
    );
  }

  group('QuickThemeSwitcher', () {
    testWidgets('toggles from retail bank to neobank when tapped', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(AppThemeMode.retailBank),
      );
      await tester.pump();

      // Initially shows dark mode icon (retail bank)
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);

      // Tap the button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify event was dispatched
      verify(mockThemeBloc.add(argThat(isA<ToggleTheme>()))).called(1);

      // Emit new state (neobank) through stream
      final neobankState = ThemeState(
        themeMode: AppThemeMode.neobank,
        themeData: AppTheme.getTheme(AppThemeMode.neobank),
      );
      when(mockThemeBloc.state).thenReturn(neobankState);
      stateController.add(neobankState);
      await tester.pumpAndSettle();

      // Button should now show light mode icon (neobank)
      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);
    });

    testWidgets('toggles from neobank to retail bank when tapped', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(AppThemeMode.neobank),
      );
      await tester.pump();

      // Initially shows light mode icon (neobank)
      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);

      // Tap the button
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify event was dispatched
      verify(mockThemeBloc.add(argThat(isA<ToggleTheme>()))).called(1);

      // Emit new state (retail bank) through stream
      final retailBankState = ThemeState(
        themeMode: AppThemeMode.retailBank,
        themeData: AppTheme.getTheme(AppThemeMode.retailBank),
      );
      when(mockThemeBloc.state).thenReturn(retailBankState);
      stateController.add(retailBankState);
      await tester.pumpAndSettle();

      // Button should now show dark mode icon (retail bank)
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);
    });
  });
}
