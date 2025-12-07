import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/utils/amount_formatter.dart';

void main() {
  group('AmountFormatter', () {
    group('formatAmount', () {
      test('formats values less than 1000 as whole numbers', () {
        expect(AmountFormatter.formatAmountToKMB(0), '0');
        expect(AmountFormatter.formatAmountToKMB(1), '1');
        expect(AmountFormatter.formatAmountToKMB(100), '100');
        expect(AmountFormatter.formatAmountToKMB(500), '500');
        expect(AmountFormatter.formatAmountToKMB(999), '999');
        expect(AmountFormatter.formatAmountToKMB(999.9), '1000');
      });

      test('formats values in thousands (1,000 - 999,999)', () {
        expect(AmountFormatter.formatAmountToKMB(1000), '1k');
        expect(AmountFormatter.formatAmountToKMB(1237), '1k');
        expect(AmountFormatter.formatAmountToKMB(145372), '145k');
        expect(AmountFormatter.formatAmountToKMB(50000), '50k');
        expect(
          AmountFormatter.formatAmountToKMB(999990),
          '1000k',
        ); // Just below 1M, rounds up
        expect(AmountFormatter.formatAmountToKMB(1234), '1k');
        expect(AmountFormatter.formatAmountToKMB(12345), '12k');
      });

      test('formats values in millions (1,000,000 - 999,999,999)', () {
        expect(AmountFormatter.formatAmountToKMB(1000000), '1M');
        expect(AmountFormatter.formatAmountToKMB(1234567), '1M');
        expect(AmountFormatter.formatAmountToKMB(50000000), '50M');
        expect(AmountFormatter.formatAmountToKMB(145372000), '145M');
        expect(
          AmountFormatter.formatAmountToKMB(999990000),
          '1000M',
        ); // Just below 1B, rounds up
        expect(AmountFormatter.formatAmountToKMB(12345678), '12M');
      });

      test('formats values in billions (>= 1,000,000,000)', () {
        expect(AmountFormatter.formatAmountToKMB(1000000000), '1B');
        expect(AmountFormatter.formatAmountToKMB(1234567890), '1B');
        expect(AmountFormatter.formatAmountToKMB(50000000000), '50B');
        expect(AmountFormatter.formatAmountToKMB(145372000000), '145B');
        expect(
          AmountFormatter.formatAmountToKMB(999990000000),
          '1000B',
        ); // Just below 1T, rounds up
        expect(AmountFormatter.formatAmountToKMB(12345678900), '12B');
      });

      test('handles negative values correctly', () {
        expect(AmountFormatter.formatAmountToKMB(-100), '-100');
        expect(AmountFormatter.formatAmountToKMB(-1237), '-1k');
        expect(AmountFormatter.formatAmountToKMB(-145372), '-145k');
        expect(AmountFormatter.formatAmountToKMB(-1234567), '-1M');
        expect(AmountFormatter.formatAmountToKMB(-1234567890), '-1B');
      });

      test('handles edge cases at boundaries', () {
        expect(AmountFormatter.formatAmountToKMB(999), '999');
        expect(AmountFormatter.formatAmountToKMB(1000), '1k');
        expect(
          AmountFormatter.formatAmountToKMB(999990),
          '1000k',
        ); // Just below 1M, rounds up
        expect(AmountFormatter.formatAmountToKMB(1000000), '1M');
        expect(
          AmountFormatter.formatAmountToKMB(999990000),
          '1000M',
        ); // Just below 1B, rounds up
        expect(AmountFormatter.formatAmountToKMB(1000000000), '1B');
      });

      test('rounds correctly to whole numbers', () {
        // Test rounding up
        expect(AmountFormatter.formatAmountToKMB(1237), '1k');
        expect(
          AmountFormatter.formatAmountToKMB(1234567),
          '1M',
        );

        // Test rounding down
        expect(AmountFormatter.formatAmountToKMB(1234), '1k');
        expect(
          AmountFormatter.formatAmountToKMB(1234567),
          '1M',
        );

        // Test .5 rounding
        expect(AmountFormatter.formatAmountToKMB(1250), '1k');
        expect(AmountFormatter.formatAmountToKMB(1250000), '1M');
        expect(AmountFormatter.formatAmountToKMB(1500), '2k'); // Rounds up
        expect(AmountFormatter.formatAmountToKMB(1500000), '2M'); // Rounds up
      });

      test('handles decimal values correctly', () {
        expect(AmountFormatter.formatAmountToKMB(123.45), '123');
        expect(AmountFormatter.formatAmountToKMB(1234.56), '1k');
        expect(AmountFormatter.formatAmountToKMB(1234567.89), '1M');
        expect(AmountFormatter.formatAmountToKMB(1234567890.12), '1B');
      });

      test('handles very large values', () {
        expect(AmountFormatter.formatAmountToKMB(1000000000000), '1000B');
        expect(AmountFormatter.formatAmountToKMB(5000000000000), '5000B');
        expect(AmountFormatter.formatAmountToKMB(1234567890123), '1235B'); // Rounds up
      });

      test('handles small decimal values less than 1', () {
        expect(AmountFormatter.formatAmountToKMB(0.5), '1');
        expect(AmountFormatter.formatAmountToKMB(0.1), '0');
        expect(AmountFormatter.formatAmountToKMB(0.9), '1');
        expect(AmountFormatter.formatAmountToKMB(99.9), '100');
      });

      test('maintains consistent formatting across ranges', () {
        // Test that formatting is consistent
        final testCases = [
          (0.0, '0'),
          (100.0, '100'),
          (1000.0, '1k'),
          (10000.0, '10k'),
          (100000.0, '100k'),
          (1000000.0, '1M'),
          (10000000.0, '10M'),
          (100000000.0, '100M'),
          (1000000000.0, '1B'),
          (10000000000.0, '10B'),
          (100000000000.0, '100B'),
        ];

        for (final (value, expected) in testCases) {
          expect(
            AmountFormatter.formatAmountToKMB(value),
            expected,
            reason: 'Failed for value: $value',
          );
        }
      });
    });

    group('formatAmountWithCurrency', () {
      test('formats small amounts correctly', () {
        expect(AmountFormatter.formatAmountWithCurrency(0), '0.00');
        expect(AmountFormatter.formatAmountWithCurrency(100), '100.00');
        expect(AmountFormatter.formatAmountWithCurrency(123.45), '123.45');
      });

      test('formats amounts with thousands separators', () {
        expect(AmountFormatter.formatAmountWithCurrency(1000), '1,000.00');
        expect(AmountFormatter.formatAmountWithCurrency(12345), '12,345.00');
        expect(AmountFormatter.formatAmountWithCurrency(11729.85), '11,729.85');
      });

      test('formats large amounts correctly (100,000,000+)', () {
        expect(
          AmountFormatter.formatAmountWithCurrency(100000000),
          '100,000,000.00',
        );
        expect(
          AmountFormatter.formatAmountWithCurrency(100000000.50),
          '100,000,000.50',
        );
        expect(
          AmountFormatter.formatAmountWithCurrency(123456789.12),
          '123,456,789.12',
        );
        expect(
          AmountFormatter.formatAmountWithCurrency(1000000000),
          '1,000,000,000.00',
        );
        expect(
          AmountFormatter.formatAmountWithCurrency(10000000000),
          '10,000,000,000.00',
        );
        expect(
          AmountFormatter.formatAmountWithCurrency(100000000000),
          '100,000,000,000.00',
        );
      });

      test('handles negative values correctly', () {
        expect(AmountFormatter.formatAmountWithCurrency(-100), '-100.00');
        expect(AmountFormatter.formatAmountWithCurrency(-12345), '-12,345.00');
        expect(
          AmountFormatter.formatAmountWithCurrency(-100000000),
          '-100,000,000.00',
        );
      });

      test('handles decimal values correctly', () {
        expect(AmountFormatter.formatAmountWithCurrency(123.45), '123.45');
        expect(AmountFormatter.formatAmountWithCurrency(1234.56), '1,234.56');
        expect(
          AmountFormatter.formatAmountWithCurrency(123456789.12),
          '123,456,789.12',
        );
      });

      test('handles very small decimal values', () {
        expect(AmountFormatter.formatAmountWithCurrency(0.01), '0.01');
        expect(AmountFormatter.formatAmountWithCurrency(0.10), '0.10');
        expect(AmountFormatter.formatAmountWithCurrency(0.99), '0.99');
      });

      test('handles precise decimal values', () {
        expect(AmountFormatter.formatAmountWithCurrency(123.999), '124.00');
        expect(AmountFormatter.formatAmountWithCurrency(123.001), '123.00');
        expect(AmountFormatter.formatAmountWithCurrency(123.995), '124.00');
      });

      test('handles edge cases', () {
        expect(AmountFormatter.formatAmountWithCurrency(0.0), '0.00');
        expect(AmountFormatter.formatAmountWithCurrency(0.00), '0.00');
        expect(AmountFormatter.formatAmountWithCurrency(1.0), '1.00');
      });
    });

    group('splitFormattedAmount', () {
      test('splits small amounts correctly', () {
        final result = AmountFormatter.splitFormattedAmount(123.45);
        expect(result[0], '123');
        expect(result[1], '.45');
      });

      test('splits amounts with thousands separators', () {
        final result = AmountFormatter.splitFormattedAmount(11729.85);
        expect(result[0], '11,729');
        expect(result[1], '.85');
      });

      test('splits large amounts correctly (100,000,000+)', () {
        final result1 = AmountFormatter.splitFormattedAmount(100000000);
        expect(result1[0], '100,000,000');
        expect(result1[1], '.00');

        final result2 = AmountFormatter.splitFormattedAmount(123456789.12);
        expect(result2[0], '123,456,789');
        expect(result2[1], '.12');

        final result3 = AmountFormatter.splitFormattedAmount(1000000000);
        expect(result3[0], '1,000,000,000');
        expect(result3[1], '.00');

        final result4 = AmountFormatter.splitFormattedAmount(10000000000);
        expect(result4[0], '10,000,000,000');
        expect(result4[1], '.00');
      });

      test('handles whole numbers without decimals', () {
        final result = AmountFormatter.splitFormattedAmount(1000);
        expect(result[0], '1,000');
        expect(result[1], '.00');
      });

      test('handles negative values correctly', () {
        final result = AmountFormatter.splitFormattedAmount(-123456789.12);
        expect(result[0], '-123,456,789');
        expect(result[1], '.12');
      });

      test('handles very small decimal values', () {
        final result = AmountFormatter.splitFormattedAmount(0.01);
        expect(result[0], '0');
        expect(result[1], '.01');
      });

      test('handles zero correctly', () {
        final result = AmountFormatter.splitFormattedAmount(0);
        expect(result[0], '0');
        expect(result[1], '.00');
      });

      test('handles precise decimal values', () {
        final result1 = AmountFormatter.splitFormattedAmount(123.999);
        expect(result1[0], '124');
        expect(result1[1], '.00');

        final result2 = AmountFormatter.splitFormattedAmount(123.001);
        expect(result2[0], '123');
        expect(result2[1], '.00');
      });

      test('returns exactly two elements in list', () {
        final result1 = AmountFormatter.splitFormattedAmount(100);
        expect(result1.length, 2);
        expect(result1[0], isA<String>());
        expect(result1[1], isA<String>());

        final result2 = AmountFormatter.splitFormattedAmount(123456789.12);
        expect(result2.length, 2);
        expect(result2[0], isA<String>());
        expect(result2[1], isA<String>());
      });

      test('split result matches formatAmountWithCurrency output', () {
        final testValues = [
          0.0,
          100.0,
          123.45,
          1000.0,
          12345.67,
          100000000.0,
          123456789.12,
        ];
        for (final value in testValues) {
          final formatted = AmountFormatter.formatAmountWithCurrency(value);
          final split = AmountFormatter.splitFormattedAmount(value);
          expect('${split[0]}${split[1]}', formatted);
        }
      });
    });
  });
}
