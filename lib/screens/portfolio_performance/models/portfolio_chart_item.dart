import 'package:portfolio_performance_demo/generated/portfolio_chart.pb.dart' as pb;
import 'package:portfolio_performance_demo/generated/google/protobuf/timestamp.pb.dart'
    as timestamp_pb;

class PortfolioChartItem {
  /// The date of the portfolio chart item.
  final DateTime date;

  /// The amount of the portfolio chart item.
  final double amount;

  /// The cumulative time-weighted performance of the portfolio in percent (%) over the performance period.
  final double percentTimeWeightedCumulated;

  /// The rate of return percentage generated until that point in time.
  final double rateOfReturnPercent;

  /// The total profit or loss amount (positive for profit, negative for loss) made until that point in time.
  final double totalProfitLoss;

  const PortfolioChartItem({
    required this.date,
    required this.amount,
    required this.percentTimeWeightedCumulated,
    required this.rateOfReturnPercent,
    required this.totalProfitLoss,
  });

  factory PortfolioChartItem.fromProto(pb.PortfolioChartItem proto) {
    return PortfolioChartItem(
      date: proto.date.toDateTime(toLocal: true),
      amount: proto.amount,
      percentTimeWeightedCumulated: proto.percentTimeWeightedCumulated,
      rateOfReturnPercent: proto.rateOfReturnPercent,
      totalProfitLoss: proto.totalProfitLoss,
    );
  }

  pb.PortfolioChartItem toProto() {
    return pb.PortfolioChartItem(
      date: timestamp_pb.Timestamp.fromDateTime(date),
      amount: amount,
      percentTimeWeightedCumulated: percentTimeWeightedCumulated,
      rateOfReturnPercent: rateOfReturnPercent,
      totalProfitLoss: totalProfitLoss,
    );
  }
}
