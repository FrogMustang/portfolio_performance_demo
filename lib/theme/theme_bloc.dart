import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Theme Events
abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

/// Theme State
class ThemeState {
  final AppThemeMode themeMode;
  final ThemeData themeData;

  ThemeState({
    required this.themeMode,
    required this.themeData,
  });
}

/// Theme BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(
        ThemeState(
          themeMode: AppThemeMode.retailBank,
          themeData: AppTheme.getTheme(AppThemeMode.retailBank),
        ),
      ) {
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    final currentMode = state.themeMode;
    final newMode = currentMode == AppThemeMode.retailBank
        ? AppThemeMode.neobank
        : AppThemeMode.retailBank;

    emit(
      ThemeState(
        themeMode: newMode,
        themeData: AppTheme.getTheme(newMode),
      ),
    );
  }
}
