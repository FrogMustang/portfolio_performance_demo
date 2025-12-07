import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:portfolio_performance_demo/theme/app_colors.dart';
import 'package:portfolio_performance_demo/theme/app_text_styles.dart';

class Utils {
  // show snackbar
  static void showSnackbar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: context.textStyles.bodyMedium.copyWith(
            color: textColor ?? context.colors.textInverse,
          ),
        ),
        backgroundColor: backgroundColor ?? context.colors.primaryAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

Logger logger = Logger();
