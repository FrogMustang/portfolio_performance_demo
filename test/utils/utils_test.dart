import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/utils/utils.dart';

void main() {
  group('Utils', () {
    testWidgets('showSnackbar displays message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: ElevatedButton(
                  onPressed: () {
                    Utils.showSnackbar(context, 'Test message');
                  },
                  child: const Text('Show Snackbar'),
                ),
              );
            },
          ),
        ),
      );

      // Tap the button to show snackbar
      await tester.tap(find.text('Show Snackbar'));
      await tester.pump();

      // Verify snackbar appears
      expect(find.text('Test message'), findsOneWidget);
    });
  });
}
