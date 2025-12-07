import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../theme/theme_bloc.dart';
import '../theme/app_theme.dart';
import '../theme/app_colors.dart';

/// A floating action button for quick theme toggling
class QuickThemeSwitcher extends StatelessWidget {
  const QuickThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final colors = context.colors;
        final isNeobank = themeState.themeMode == AppThemeMode.neobank;

        return FloatingActionButton(
          onPressed: () {
            // Toggle between neobank and retailBank
            final newTheme = isNeobank ? AppThemeMode.retailBank : AppThemeMode.neobank;
            context.read<ThemeBloc>().add(ChangeTheme(newTheme));
          },
          backgroundColor: colors.buttonPrimary,
          child: Icon(
            isNeobank ? Icons.light_mode : Icons.dark_mode,
            color: colors.textInverse,
          ),
        );
      },
    );
  }
}
