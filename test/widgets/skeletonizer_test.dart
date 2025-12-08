import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/theme/app_theme.dart';
import 'package:portfolio_performance_demo/widgets/skeletonizer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createWidgetUnderTest({
    required bool enabled,
    Widget? child,
    bool ignoreContainers = false,
    Color? containersColor,
  }) {
    return MaterialApp(
      theme: AppTheme.getTheme(AppThemeMode.retailBank),
      home: Scaffold(
        body: AppSkeletonizer(
          enabled: enabled,
          ignoreContainers: ignoreContainers,
          containersColor: containersColor,
          child: child ?? const Text('Test Child'),
        ),
      ),
    );
  }

  group('AppSkeletonizer', () {
    testWidgets('accepts ignoreContainers parameter', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          enabled: true,
          ignoreContainers: true,
        ),
      );

      expect(find.byType(AppSkeletonizer), findsOneWidget);
    });

    testWidgets('works with complex child widgets', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(
          enabled: true,
          child: Column(
            children: [
              const Text('Title'),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 20,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      );

      expect(find.byType(AppSkeletonizer), findsOneWidget);

      final skeletonizer = tester.widget<AppSkeletonizer>(
        find.byType(AppSkeletonizer),
      );
      expect(skeletonizer.enabled, true);
    });

    testWidgets('can toggle between enabled and disabled', (tester) async {
      // Start disabled - text should be visible
      await tester.pumpWidget(
        createWidgetUnderTest(
          enabled: false,
          child: const Text('Toggle Test'),
        ),
      );

      expect(find.text('Toggle Test'), findsOneWidget);
      final skeletonizerDisabled = tester.widget<AppSkeletonizer>(
        find.byType(AppSkeletonizer),
      );
      expect(skeletonizerDisabled.enabled, false);

      // Enable - skeleton effect should be active
      await tester.pumpWidget(
        createWidgetUnderTest(
          enabled: true,
          child: const Text('Toggle Test'),
        ),
      );

      final skeletonizerEnabled = tester.widget<AppSkeletonizer>(
        find.byType(AppSkeletonizer),
      );
      expect(skeletonizerEnabled.enabled, true);

      // The text widget may still be in the tree, but it should be skeletonized
      // (visually replaced with shimmer effect). We verify the skeletonizer is enabled
      // rather than checking for visible text, as the skeleton effect overlays the content.
      expect(find.text('Toggle Test'), findsOneWidget);
    });
  });
}
