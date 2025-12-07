import 'package:intl/intl.dart';

class AmountFormatter {
  /// Format amount with k (thousands), M (millions), B (billions)
  /// Examples: 100 -> "100", 1237 -> "1.24 k", 145372 -> "145.37 k"
  static String formatAmountToKMB(double value) {
    final absValue = value.abs();

    if (absValue < 1000) {
      return value.toStringAsFixed(0);
    } else if (absValue < 1000000) {
      // Thousands
      final kValue = value / 1000;
      return '${kValue.toStringAsFixed(0)}k';
    } else if (absValue < 1000000000) {
      // Millions
      final mValue = value / 1000000;
      return '${mValue.toStringAsFixed(0)}M';
    } else {
      // Billions
      final bValue = value / 1000000000;
      return '${bValue.toStringAsFixed(0)}B';
    }
  }

  /// Format amount with thousands separators
  /// Returns formatted string like "11,729.85" or "100,000,000.00"
  static String formatAmountWithCurrency(double value) {
    // Use a pattern that handles any size number with thousands separators
    // The pattern #,##0.00 automatically handles all thousands groups
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(value);
  }

  /// Split formatted amount into parts: [integerPart, decimalPart]
  /// Example: 11729.85 -> ["11,729", ".85"]
  /// Example: 100000000.00 -> ["100,000,000", ".00"]
  static List<String> splitFormattedAmount(double value) {
    final formatted = formatAmountWithCurrency(value);
    final parts = formatted.split('.');

    if (parts.length == 2) {
      return [parts[0], '.${parts[1]}'];
    } else {
      // no decimal point present
      return [formatted, ''];
    }
  }
}
