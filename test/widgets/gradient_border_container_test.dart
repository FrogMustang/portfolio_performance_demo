import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/gradient_border_container.dart';

void main() {
  group('GradientBorderContainer', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: GradientBorderContainer(
              child: Text('Test Child'),
            ),
          ),
        ),
      );

      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('has gradient border decoration', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: GradientBorderContainer(
              child: Text('Test'),
            ),
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      expect(containers.length, greaterThanOrEqualTo(2));

      // Outer container should have gradient decoration
      final outerContainer = containers.first;
      expect(outerContainer.decoration, isA<BoxDecoration>());
      final decoration = outerContainer.decoration as BoxDecoration;
      expect(decoration.gradient, isA<LinearGradient>());
    });

    testWidgets('has correct padding for border effect', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: GradientBorderContainer(
              child: Text('Test'),
            ),
          ),
        ),
      );

      final containers = tester.widgetList<Container>(find.byType(Container));
      final outerContainer = containers.first;

      expect(outerContainer.padding, const EdgeInsets.all(0.3));
    });

    testWidgets('works with complex child widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.getTheme(AppThemeMode.retailBank),
          home: Scaffold(
            body: GradientBorderContainer(
              child: Column(
                children: [
                  Text('Title'),
                  Text('Subtitle'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subtitle'), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
    });
  });
}
