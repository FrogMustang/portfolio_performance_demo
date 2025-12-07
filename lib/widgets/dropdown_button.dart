import 'package:flutter/material.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';
import 'package:portfolio_performance_demo/widgets/gradient_border_container.dart';
import 'package:portfolio_performance_demo/widgets/selectable_card_item.dart';

/// A dropdown button that shows a bottom sheet with selectable options
class GradientDropdownButton<T> extends StatelessWidget {
  /// The currently selected value
  final T selectedValue;

  /// Used to get the text that is shown for the selected option in the button preview
  final String Function(T) getDisplayText;

  /// List of options to choose from
  final List<T> options;

  /// Callback when an option is selected
  final void Function(T) onSelected;

  const GradientDropdownButton({
    super.key,
    required this.selectedValue,
    required this.getDisplayText,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return GestureDetector(
      onTap: () => _showBottomSheet(context),
      child: GradientBorderContainer(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SELECTED OPTION TEXT
            Text(
              getDisplayText(selectedValue),
              style: textStyles.titleMedium.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),

            // ARROW ICON
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colors.textPrimary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final colors = context.colors;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: colors.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Options list
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: options.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final option = options[index];
                  final isSelected = selectedValue == option;

                  return SelectableCardItem(
                    title: getDisplayText(option),
                    isSelected: isSelected,
                    onTap: () {
                      onSelected(option);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
