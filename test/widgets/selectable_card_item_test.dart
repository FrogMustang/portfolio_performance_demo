import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/selectable_card_item.dart';

void main() {
  group('SelectableCardItem', () {
    testWidgets('displays title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: SelectableCardItem(
              title: 'Test Item',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Item'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: SelectableCardItem(
              title: 'Test Item',
              isSelected: false,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Item'));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('shows selected state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: SelectableCardItem(
              title: 'Selected',
              isSelected: true,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Selected'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows unselected state', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: SelectableCardItem(
              title: 'Unselected',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Unselected'), findsOneWidget);
      expect(
        find.byWidgetPredicate((widget) => widget is Icon || widget is IconData),
        findsNothing,
      );
    });
  });
}
