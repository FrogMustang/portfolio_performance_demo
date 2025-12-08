import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/dropdown_button.dart';
import 'package:portfolio_performance_demo/widgets/gradient_border_container.dart';
import 'package:portfolio_performance_demo/widgets/selectable_card_item.dart';

enum TestOption { option1, option2, option3 }

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String getDisplayText(TestOption option) {
    switch (option) {
      case TestOption.option1:
        return 'Option 1';
      case TestOption.option2:
        return 'Option 2';
      case TestOption.option3:
        return 'Option 3';
    }
  }

  Widget createWidgetUnderTest({
    required TestOption selectedValue,
    required void Function(TestOption) onSelected,
  }) {
    return MaterialApp(
      theme: AppTheme.getTheme(AppThemeMode.retailBank),
      home: Scaffold(
        body: Center(
          child: GradientDropdownButton<TestOption>(
            selectedValue: selectedValue,
            getDisplayText: getDisplayText,
            options: TestOption.values,
            onSelected: onSelected,
          ),
        ),
      ),
    );
  }

  group('GradientDropdownButton', () {
    testWidgets('widget displays option correctly', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          selectedValue: TestOption.option1,
          onSelected: (_) {},
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down_rounded), findsOneWidget);
      expect(find.byType(GradientBorderContainer), findsOneWidget);
    });

    testWidgets('opens bottom sheet on tap', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          selectedValue: TestOption.option1,
          onSelected: (_) {},
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // Bottom sheet should be visible
      expect(find.text('Option 1'), findsNWidgets(2)); // One in button, one in sheet
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);

      expect(find.byType(SelectableCardItem), findsNWidgets(3));
    });

    testWidgets('selects option and closes bottom sheet', (tester) async {
      TestOption selectedOption = TestOption.option1;

      await tester.pumpWidget(
        createWidgetUnderTest(
          selectedValue: selectedOption,
          onSelected: (option) {
            selectedOption = option;
          },
        ),
      );

      // Open bottom sheet
      await tester.tap(find.byType(GradientBorderContainer));
      await tester.pumpAndSettle();

      // Tap on Option 2
      await tester.tap(find.text('Option 2').last);
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(selectedOption, TestOption.option2);

      // Rebuild widget with new selected value
      await tester.pumpWidget(
        createWidgetUnderTest(
          selectedValue: selectedOption,
          onSelected: (option) {
            selectedOption = option;
          },
        ),
      );
      await tester.pump();

      // Bottom sheet should be closed and button shows new value
      expect(find.text('Option 2'), findsOneWidget);
    });

    testWidgets('highlights selected option in bottom sheet', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          selectedValue: TestOption.option2,
          onSelected: (_) {},
        ),
      );

      await tester.tap(find.byType(GradientBorderContainer));
      await tester.pumpAndSettle();

      // Find the SelectableCardItem widgets
      final selectableItems = tester.widgetList<SelectableCardItem>(
        find.byType(SelectableCardItem),
      );

      // Option 2 should be selected (it's the second item, index 1)
      final option2Item = selectableItems.elementAt(1);
      expect(option2Item.isSelected, true);

      // Others should not be selected
      final option1Item = selectableItems.elementAt(0);
      final option3Item = selectableItems.elementAt(2);
      expect(option1Item.isSelected, false);
      expect(option3Item.isSelected, false);
    });

    testWidgets('updates displayed text when selection changes', (tester) async {
      TestOption currentSelection = TestOption.option1;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              theme: AppTheme.getTheme(AppThemeMode.retailBank),
              home: Scaffold(
                body: Center(
                  child: GradientDropdownButton<TestOption>(
                    selectedValue: currentSelection,
                    getDisplayText: getDisplayText,
                    options: TestOption.values,
                    onSelected: (option) {
                      setState(() {
                        currentSelection = option;
                      });
                    },
                  ),
                ),
              ),
            );
          },
        ),
      );

      expect(find.text('Option 1'), findsOneWidget);

      // Open and select Option 3
      await tester.tap(find.byType(GradientBorderContainer));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Option 3').last);
      await tester.pumpAndSettle();

      expect(find.text('Option 3'), findsOneWidget);
      expect(find.text('Option 1'), findsNothing);
    });
  });
}
