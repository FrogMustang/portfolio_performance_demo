import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/app_icon_button.dart';

void main() {
  group('RoundIconButton', () {
    testWidgets('displays and calls onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: RoundIconButton(
              icon: Icons.search,
              onPressed: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(RoundIconButton));
      await tester.pump();

      expect(tapped, true);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });
}
