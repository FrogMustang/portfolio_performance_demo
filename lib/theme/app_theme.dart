import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Available theme modes
enum AppThemeMode {
  retailBank,
  neobank,
}

/// App theme configuration class
class AppTheme {
  /// Get ThemeData for a specific theme mode
  static ThemeData getTheme(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.retailBank:
        return _retailBankTheme();
      case AppThemeMode.neobank:
        return _neobankTheme();
    }
  }

  /// 🎨 Retail Bank Theme (Light / Clean / Ocean Blues)
  static ThemeData _retailBankTheme() {
    const colors = AppColors.retailBank;
    final textStyles = AppTextStyles.light(
      colors.textPrimary,
      colors.textSecondary,
    );

    return ThemeData(
      brightness: Brightness.light,

      // Color scheme
      colorScheme: ColorScheme.light(
        primary: colors.primaryAccent,
        secondary: colors.secondaryAccent,
        tertiary: colors.primaryLight,
        surface: colors.surfaceColor,
        error: colors.negativeColor,
        onPrimary: colors.textInverse,
        onSecondary: colors.textInverse,
        onSurface: colors.textPrimary,
        onError: colors.textInverse,
      ),

      // Scaffold background
      scaffoldBackgroundColor: colors.backgroundPrimary,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: colors.primaryAccent,
        foregroundColor: colors.textInverse,
        elevation: 2,
        centerTitle: true,
        titleTextStyle: textStyles.titleLarge.copyWith(
          color: colors.textInverse,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: colors.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.buttonPrimary,
          foregroundColor: colors.textInverse,
          textStyle: textStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.buttonPrimary,
          textStyle: textStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(color: colors.buttonPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.buttonPrimary,
          textStyle: textStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: colors.iconColor,
        size: 24,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.dividerColor,
        thickness: 1,
      ),

      // Add custom extensions
      extensions: <ThemeExtension<dynamic>>[
        colors,
        textStyles,
      ],
    );
  }

  /// 💠 Neobank Theme (Dark Army Green with Neon Yellow - Material 3)
  static ThemeData _neobankTheme() {
    const colors = AppColors.neobank;
    final textStyles = AppTextStyles.dark(
      colors.textPrimary,
      colors.textSecondary,
    );

    return ThemeData(
      brightness: Brightness.dark,

      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: colors.primaryAccent,
        secondary: colors.secondaryAccent,
        tertiary: colors.primaryLight,
        surface: colors.surfaceColor,
        error: colors.negativeColor,
        onPrimary: colors.textInverse,
        onSecondary: colors.textInverse,
        onSurface: colors.textPrimary,
        onError: colors.textInverse,
      ),

      // Scaffold background
      scaffoldBackgroundColor: colors.backgroundPrimary,

      // App bar theme - Clean dark with subtle elevation
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundSecondary,
        foregroundColor: colors.textPrimary,
        elevation: 2,
        centerTitle: true,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        titleTextStyle: textStyles.titleLarge.copyWith(
          color: colors.textPrimary,
        ),
      ),

      // Card theme - Subtle elevation like the crypto design
      cardTheme: CardThemeData(
        color: colors.cardBackground,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colors.dividerColor.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),

      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.buttonPrimary,
          foregroundColor: colors.textInverse,
          textStyle: textStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Outlined button theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.buttonPrimary,
          textStyle: textStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          side: BorderSide(color: colors.buttonPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // Text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.buttonPrimary,
          textStyle: textStyles.buttonText,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      // Icon theme
      iconTheme: IconThemeData(
        color: colors.iconColor,
        size: 24,
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colors.dividerColor,
        thickness: 1,
      ),

      // Add custom extensions
      extensions: <ThemeExtension<dynamic>>[
        colors,
        textStyles,
      ],
    );
  }
}
