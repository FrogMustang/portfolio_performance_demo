import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Theme Events
abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {
  final AppThemeMode themeMode;

  ChangeTheme(this.themeMode);
}

class ToggleTheme extends ThemeEvent {}

/// Theme State
class ThemeState {
  final AppThemeMode themeMode;
  final ThemeData themeData;

  ThemeState({
    required this.themeMode,
    required this.themeData,
  });

  ThemeState copyWith({
    AppThemeMode? themeMode,
    ThemeData? themeData,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      themeData: themeData ?? this.themeData,
    );
  }

  /// Get the name of the theme
  String get themeName {
    switch (themeMode) {
      case AppThemeMode.retailBank:
        return 'Retail Bank';
      case AppThemeMode.neobank:
        return 'Neobank';
    }
  }

  /// Get the icon for the theme
  IconData get themeIcon {
    switch (themeMode) {
      case AppThemeMode.retailBank:
        return Icons.account_balance;
      case AppThemeMode.neobank:
        return Icons.phone_android;
    }
  }

  /// Get the description for the theme
  String get themeDescription {
    switch (themeMode) {
      case AppThemeMode.retailBank:
        return 'Light / Ocean Blues';
      case AppThemeMode.neobank:
        return 'Dark - Neon Yellow/Lime';
    }
  }
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
    on<ChangeTheme>(_onChangeTheme);
    on<ToggleTheme>(_onToggleTheme);
  }

  void _onChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) {
    emit(
      ThemeState(
        themeMode: event.themeMode,
        themeData: AppTheme.getTheme(event.themeMode),
      ),
    );
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
