import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/theme/theme_bloc.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeBloc', () {
    late ThemeBloc bloc;

    setUp(() {
      bloc = ThemeBloc();
    });

    tearDown(() {
      bloc.close();
    });

    group('ToggleTheme', () {
      blocTest<ThemeBloc, ThemeState>(
        'switches from retailBank to neobank',
        build: () => bloc,
        act: (bloc) => bloc.add(ToggleTheme()),
        verify: (bloc) {
          expect(bloc.state.themeMode, AppThemeMode.neobank);
          final expectedTheme = AppTheme.getTheme(AppThemeMode.neobank);
          expect(bloc.state.themeData.brightness, expectedTheme.brightness);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'switches from neobank to retailBank',
        build: () => bloc,
        seed: () => ThemeState(
          themeMode: AppThemeMode.neobank,
          themeData: AppTheme.getTheme(AppThemeMode.neobank),
        ),
        act: (bloc) => bloc.add(ToggleTheme()),
        verify: (bloc) {
          expect(bloc.state.themeMode, AppThemeMode.retailBank);
          final expectedTheme = AppTheme.getTheme(AppThemeMode.retailBank);
          expect(bloc.state.themeData.brightness, expectedTheme.brightness);
        },
      );

      blocTest<ThemeBloc, ThemeState>(
        'handles multiple consecutive toggles',
        build: () => bloc,
        act: (bloc) {
          bloc.add(ToggleTheme()); // retailBank -> neobank
          bloc.add(ToggleTheme()); // neobank -> retailBank
          bloc.add(ToggleTheme()); // retailBank -> neobank
        },
        verify: (bloc) {
          expect(bloc.state.themeMode, AppThemeMode.neobank);
          final expectedTheme = AppTheme.getTheme(AppThemeMode.neobank);
          expect(bloc.state.themeData.brightness, expectedTheme.brightness);
        },
      );
    });
  });
}
