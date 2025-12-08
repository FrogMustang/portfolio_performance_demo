import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    test('retailBank theme has all required colors', () {
      const colors = AppColors.retailBank;

      expect(colors.backgroundPrimary, isA<Color>());
      expect(colors.backgroundSecondary, isA<Color>());
      expect(colors.cardBackground, isA<Color>());
      expect(colors.surfaceColor, isA<Color>());
      expect(colors.primaryAccent, isA<Color>());
      expect(colors.secondaryAccent, isA<Color>());
      expect(colors.primaryLight, isA<Color>());
      expect(colors.textPrimary, isA<Color>());
      expect(colors.textSecondary, isA<Color>());
      expect(colors.textInverse, isA<Color>());
      expect(colors.positiveColor, isA<Color>());
      expect(colors.negativeColor, isA<Color>());
      expect(colors.dividerColor, isA<Color>());
      expect(colors.buttonPrimary, isA<Color>());
    });

    test('neobank theme has all required colors', () {
      const colors = AppColors.neobank;

      expect(colors.backgroundPrimary, isA<Color>());
      expect(colors.backgroundSecondary, isA<Color>());
      expect(colors.cardBackground, isA<Color>());
      expect(colors.surfaceColor, isA<Color>());
      expect(colors.primaryAccent, isA<Color>());
      expect(colors.secondaryAccent, isA<Color>());
      expect(colors.primaryLight, isA<Color>());
      expect(colors.textPrimary, isA<Color>());
      expect(colors.textSecondary, isA<Color>());
      expect(colors.textInverse, isA<Color>());
      expect(colors.positiveColor, isA<Color>());
      expect(colors.negativeColor, isA<Color>());
      expect(colors.dividerColor, isA<Color>());
      expect(colors.buttonPrimary, isA<Color>());
    });

    test('retailBank theme has light colors', () {
      const colors = AppColors.retailBank;

      // Background should be light
      expect(colors.backgroundPrimary.computeLuminance(), greaterThan(0.5));
    });

    test('neobank theme has dark colors', () {
      const colors = AppColors.neobank;

      // Background should be dark
      expect(colors.backgroundPrimary.computeLuminance(), lessThan(0.5));
    });

    test('positive color is green-ish', () {
      final retailBankPositive = AppColors.retailBank.positiveColor;
      final neobankPositive = AppColors.neobank.positiveColor;

      // Green has more green component
      expect(
        (retailBankPositive.g * 255.0).round(),
        greaterThan((retailBankPositive.r * 255.0).round()),
      );
      expect(
        (neobankPositive.g * 255.0).round(),
        greaterThan((neobankPositive.r * 255.0).round()),
      );
    });

    group('copyWith', () {
      test('updates single color property', () {
        const original = AppColors.retailBank;
        const newColor = Color(0xFFFF0000);

        final updated = original.copyWith(primaryAccent: newColor) as AppColors;

        expect(updated.primaryAccent, newColor);
        expect(updated.backgroundPrimary, original.backgroundPrimary);
        expect(updated.textPrimary, original.textPrimary);
      });

      test('updates multiple color properties', () {
        const original = AppColors.retailBank;
        const newPrimary = Color(0xFFFF0000);
        const newBackground = Color(0xFF00FF00);

        final updated =
            original.copyWith(
                  primaryAccent: newPrimary,
                  backgroundPrimary: newBackground,
                )
                as AppColors;

        expect(updated.primaryAccent, newPrimary);
        expect(updated.backgroundPrimary, newBackground);
        expect(updated.textPrimary, original.textPrimary);
      });

      test('returns same values when no parameters provided', () {
        const original = AppColors.retailBank;

        final updated = original.copyWith() as AppColors;

        expect(updated.primaryAccent, original.primaryAccent);
        expect(updated.backgroundPrimary, original.backgroundPrimary);
        expect(updated.textPrimary, original.textPrimary);
      });

      test('can update all button colors', () {
        const original = AppColors.neobank;
        const newButtonPrimary = Color(0xFFFF0000);
        const newButtonSecondary = Color(0xFF00FF00);

        final updated =
            original.copyWith(
                  buttonPrimary: newButtonPrimary,
                  buttonSecondary: newButtonSecondary,
                )
                as AppColors;

        expect(updated.buttonPrimary, newButtonPrimary);
        expect(updated.buttonSecondary, newButtonSecondary);
      });

      test('can update all icon colors', () {
        const original = AppColors.retailBank;
        const newIconColor = Color(0xFFFF0000);
        const newIconColorSecondary = Color(0xFF00FF00);

        final updated =
            original.copyWith(
                  iconColor: newIconColor,
                  iconColorSecondary: newIconColorSecondary,
                )
                as AppColors;

        expect(updated.iconColor, newIconColor);
        expect(updated.iconColorSecondary, newIconColorSecondary);
      });
    });

    group('lerp', () {
      test('lerp at 0.0 returns original colors', () {
        const retailBank = AppColors.retailBank;
        const neobank = AppColors.neobank;

        final result = retailBank.lerp(neobank, 0.0) as AppColors;

        expect(result.primaryAccent, retailBank.primaryAccent);
        expect(result.backgroundPrimary, retailBank.backgroundPrimary);
      });

      test('lerp at 1.0 returns other colors', () {
        const retailBank = AppColors.retailBank;
        const neobank = AppColors.neobank;

        final result = retailBank.lerp(neobank, 1.0) as AppColors;

        expect(result.primaryAccent, neobank.primaryAccent);
        expect(result.backgroundPrimary, neobank.backgroundPrimary);
      });

      test('lerp at 0.5 returns interpolated colors', () {
        const retailBank = AppColors.retailBank;
        const neobank = AppColors.neobank;

        final result = retailBank.lerp(neobank, 0.5) as AppColors;

        // Should be between the two colors
        expect(result.primaryAccent, isNot(retailBank.primaryAccent));
        expect(result.primaryAccent, isNot(neobank.primaryAccent));
      });

      test('lerp with null returns original', () {
        const retailBank = AppColors.retailBank;

        final result = retailBank.lerp(null, 0.5) as AppColors;

        expect(result.primaryAccent, retailBank.primaryAccent);
        expect(result.backgroundPrimary, retailBank.backgroundPrimary);
      });

      test('lerp interpolates all color properties', () {
        const retailBank = AppColors.retailBank;
        const neobank = AppColors.neobank;

        final result = retailBank.lerp(neobank, 0.3) as AppColors;

        // All colors should be interpolated, not equal to either original
        expect(result.textPrimary, isNot(retailBank.textPrimary));
        expect(result.textPrimary, isNot(neobank.textPrimary));
        expect(result.cardBackground, isNot(retailBank.cardBackground));
        expect(result.cardBackground, isNot(neobank.cardBackground));
      });
    });

    test('AppColors is a ThemeExtension', () {
      const colors = AppColors.retailBank;
      expect(colors, isA<ThemeExtension<AppColors>>());
    });

    test('copyWith can update text colors', () {
      const original = AppColors.neobank;
      const newTextPrimary = Color(0xFFFF0000);
      const newTextSecondary = Color(0xFF00FF00);
      const newTextInverse = Color(0xFF0000FF);

      final updated =
          original.copyWith(
                textPrimary: newTextPrimary,
                textSecondary: newTextSecondary,
                textInverse: newTextInverse,
              )
              as AppColors;

      expect(updated.textPrimary, newTextPrimary);
      expect(updated.textSecondary, newTextSecondary);
      expect(updated.textInverse, newTextInverse);
    });

    test('copyWith can update status colors', () {
      const original = AppColors.retailBank;
      const newPositive = Color(0xFF00FF00);
      const newNegative = Color(0xFFFF0000);

      final updated =
          original.copyWith(
                positiveColor: newPositive,
                negativeColor: newNegative,
              )
              as AppColors;

      expect(updated.positiveColor, newPositive);
      expect(updated.negativeColor, newNegative);
    });
  });
}
