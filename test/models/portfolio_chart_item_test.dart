import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/generated/google/protobuf/timestamp.pb.dart'
    as timestamp_pb;
import 'package:portfolio_performance_demo/generated/portfolio_chart.pb.dart' as pb;
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';

void main() {
  group('PortfolioChartItem', () {
    test('creates instance with all fields correctly', () {
      final date = DateTime(2024, 1, 1, 12, 0);
      final item = PortfolioChartItem(
        date: date,
        amount: 100000.0,
        percentTimeWeightedCumulated: 5.5,
        rateOfReturnPercent: 5.5,
        totalProfitLoss: 5000.0,
      );

      expect(item.date, date);
      expect(item.amount, 100000.0);
      expect(item.percentTimeWeightedCumulated, 5.5);
      expect(item.rateOfReturnPercent, 5.5);
      expect(item.totalProfitLoss, 5000.0);
    });

    test('fromProto converts protobuf message correctly', () {
      final testDate = DateTime.utc(2024, 1, 1, 12, 0);
      final timestamp = timestamp_pb.Timestamp.fromDateTime(testDate);

      final proto = pb.PortfolioChartItem()
        ..date = timestamp
        ..amount = 100000.0
        ..percentTimeWeightedCumulated = -5.5
        ..rateOfReturnPercent = 5.5
        ..totalProfitLoss = -5000.0;

      final item = PortfolioChartItem.fromProto(proto);

      expect(item.date, testDate.toLocal());
      expect(item.amount, 100000.0);
      expect(item.percentTimeWeightedCumulated, -5.5);
      expect(item.rateOfReturnPercent, 5.5);
      expect(item.totalProfitLoss, -5000.0);
    });

    test('toProto converts to protobuf message correctly', () {
      final date = DateTime(2024, 1, 1, 12, 0);
      final item = PortfolioChartItem(
        date: date,
        amount: -100000.0,
        percentTimeWeightedCumulated: 5.5,
        rateOfReturnPercent: -5.5,
        totalProfitLoss: 5000.0,
      );

      final proto = item.toProto();

      // Compare timestamps as milliseconds since epoch to avoid timezone issues
      expect(proto.date.toDateTime().millisecondsSinceEpoch, date.millisecondsSinceEpoch);
      expect(proto.amount, -100000.0);
      expect(proto.percentTimeWeightedCumulated, 5.5);
      expect(proto.rateOfReturnPercent, -5.5);
      expect(proto.totalProfitLoss, 5000.0);
    });

    test('fromProto and toProto are reversible', () {
      final originalDate = DateTime(2024, 1, 1, 12, 0);
      final original = PortfolioChartItem(
        date: originalDate,
        amount: 150000.0,
        percentTimeWeightedCumulated: 10.0,
        rateOfReturnPercent: 10.0,
        totalProfitLoss: 15000.0,
      );

      final proto = original.toProto();
      final converted = PortfolioChartItem.fromProto(proto);

      // Compare timestamps as milliseconds since epoch to avoid timezone issues
      expect(converted.date.millisecondsSinceEpoch, originalDate.millisecondsSinceEpoch);
      expect(converted.amount, original.amount);
      expect(
        converted.percentTimeWeightedCumulated,
        original.percentTimeWeightedCumulated,
      );
      expect(converted.rateOfReturnPercent, original.rateOfReturnPercent);
      expect(converted.totalProfitLoss, original.totalProfitLoss);
    });
  });
}
