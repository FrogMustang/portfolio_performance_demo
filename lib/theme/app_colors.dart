import 'package:flutter/material.dart';

/// Custom color scheme that extends ThemeExtension
/// This allows you to define custom named colors for your theme
class AppColors extends ThemeExtension<AppColors> {
  // Primary colors
  final Color primaryAccent;
  final Color primaryLight;
  final Color secondaryAccent;

  // Background colors
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color backgroundElevated;

  // Text colors
  final Color textPrimary;
  final Color textSecondary;
  final Color textInverse;

  // Status colors
  final Color positiveColor;
  final Color negativeColor;

  // Card and surface colors
  final Color cardBackground;
  final Color surfaceColor;
  final Color dividerColor;

  // Interactive colors
  final Color buttonPrimary;
  final Color buttonSecondary;
  final Color iconColor;
  final Color iconColorSecondary;

  const AppColors({
    required this.primaryAccent,
    required this.primaryLight,
    required this.secondaryAccent,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundElevated,
    required this.textPrimary,
    required this.textSecondary,
    required this.textInverse,
    required this.positiveColor,
    required this.negativeColor,
    required this.cardBackground,
    required this.surfaceColor,
    required this.dividerColor,
    required this.buttonPrimary,
    required this.buttonSecondary,
    required this.iconColor,
    required this.iconColorSecondary,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primaryAccent,
    Color? primaryLight,
    Color? secondaryAccent,
    Color? backgroundPrimary,
    Color? backgroundSecondary,
    Color? backgroundElevated,
    Color? textPrimary,
    Color? textSecondary,
    Color? textInverse,
    Color? positiveColor,
    Color? negativeColor,
    Color? cardBackground,
    Color? surfaceColor,
    Color? dividerColor,
    Color? buttonPrimary,
    Color? buttonSecondary,
    Color? iconColor,
    Color? iconColorSecondary,
  }) {
    return AppColors(
      primaryAccent: primaryAccent ?? this.primaryAccent,
      primaryLight: primaryLight ?? this.primaryLight,
      secondaryAccent: secondaryAccent ?? this.secondaryAccent,
      backgroundPrimary: backgroundPrimary ?? this.backgroundPrimary,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundElevated: backgroundElevated ?? this.backgroundElevated,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textInverse: textInverse ?? this.textInverse,
      positiveColor: positiveColor ?? this.positiveColor,
      negativeColor: negativeColor ?? this.negativeColor,
      cardBackground: cardBackground ?? this.cardBackground,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      dividerColor: dividerColor ?? this.dividerColor,
      buttonPrimary: buttonPrimary ?? this.buttonPrimary,
      buttonSecondary: buttonSecondary ?? this.buttonSecondary,
      iconColor: iconColor ?? this.iconColor,
      iconColorSecondary: iconColorSecondary ?? this.iconColorSecondary,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      secondaryAccent: Color.lerp(secondaryAccent, other.secondaryAccent, t)!,
      backgroundPrimary: Color.lerp(backgroundPrimary, other.backgroundPrimary, t)!,
      backgroundSecondary: Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundElevated: Color.lerp(backgroundElevated, other.backgroundElevated, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      positiveColor: Color.lerp(positiveColor, other.positiveColor, t)!,
      negativeColor: Color.lerp(negativeColor, other.negativeColor, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      buttonPrimary: Color.lerp(buttonPrimary, other.buttonPrimary, t)!,
      buttonSecondary: Color.lerp(buttonSecondary, other.buttonSecondary, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      iconColorSecondary: Color.lerp(iconColorSecondary, other.iconColorSecondary, t)!,
    );
  }

  static const AppColors retailBank = AppColors(
    // Primary (Brand Blue family)
    primaryAccent: Color(0xFF0A6CFF), // Strong Corporate Blue
    primaryLight: Color(0xFF66A8FF), // Soft Light Blue
    secondaryAccent: Color(0xFF3E4C66), // Desaturated cool gray-blue
    // Backgrounds (Clean, Very Light)
    backgroundPrimary: Color(0xFFF7F9FC), // Clean white-blue
    backgroundSecondary: Color(0xFFE9F1F9),
    backgroundElevated: Color(0xFFFFFFFF),

    // Cards / Surfaces
    cardBackground: Color(0xFFFFFFFF),
    surfaceColor: Color(0xFFF7F9FC),

    // Dividers
    dividerColor: Color(0xFFD9E4F2),

    // Text
    textPrimary: Color(0xFF0D1B2A), // Deep Navy
    textSecondary: Color(0xFF4A5B73), // Soft blue-gray
    textInverse: Color(0xFFFFFFFF),

    // Status
    positiveColor: Color(0xFF1FC77E), // Strong green (finance-friendly)
    negativeColor: Color(0xFFE53935), // Material red
    // Buttons / Icons
    buttonPrimary: Color(0xFF0A6CFF),
    buttonSecondary: Color(0xFFE3E9F1), // Light muted gray
    iconColor: Color(0xFF0A6CFF),
    iconColorSecondary: Color(0xFF4A5B73),
  );

  /// 💠 Neobank Theme (Updated — Dark Futuristic Neon Cyan)
  static const AppColors neobank = AppColors(
    // Primary Neon Colors
    primaryAccent: Color(0xFF0FFFC6), // Neon Aqua (high contrast)
    primaryLight: Color(0xFF6CFFE5), // Soft neon glow
    secondaryAccent: Color(0xFF00C7A4), // Deep aqua green
    // Dark Surfaces (Smooth + Futuristic)
    backgroundPrimary: Color(0xFF0E1113), // Carbon black
    backgroundSecondary: Color(0xFF161A1D),
    backgroundElevated: Color(0xFF1E2427),

    // Cards / Surfaces
    cardBackground: Color(0xFF161A1D),
    surfaceColor: Color(0xFF0E1113),

    // Dividers
    dividerColor: Color(0xFF2A2F33),

    // Text (High Contrast)
    textPrimary: Color(0xFFE8F7F4), // Light aqua-white
    textSecondary: Color(0xFF8FA3A0), // Muted greenish-gray
    textInverse: Color(0xFF0E1113),

    // Status Colors
    positiveColor: Color(0xFF3DFF9D), // Neon green
    negativeColor: Color(0xFFFF4F70), // Neon red/pink
    // Buttons / Icons
    buttonPrimary: Color(0xFF0FFFC6), // Same neon aqua
    buttonSecondary: Color(0xFF2A2F33),
    iconColor: Color(0xFF0FFFC6),
    iconColorSecondary: Color(0xFF8FA3A0),
  );
}

/// Extension to easily access custom colors from BuildContext
extension AppColorsExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

/// Extension to access custom colors directly from ThemeData
extension ThemeDataColorsExtension on ThemeData {
  AppColors get colors => extension<AppColors>()!;
}
