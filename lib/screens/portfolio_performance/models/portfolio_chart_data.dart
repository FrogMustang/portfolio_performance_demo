import 'package:portfolio_performance_demo/generated/portfolio_chart.pb.dart' as pb;
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_chart_item.dart';

class PortfolioChartData {
  final List<PortfolioChartItem> items;

  PortfolioChartData({
    required this.items,
  });

  factory PortfolioChartData.fromProto(pb.PortfolioChartResponse proto) {
    return PortfolioChartData(
      items: proto.items.map((item) => PortfolioChartItem.fromProto(item)).toList(),
    );
  }

  // uncomment if needed
  // pb.PortfolioChartResponse toProto() {
  //   return pb.PortfolioChartResponse(
  //     items: items.map((item) => item.toProto()).toList(),
  //   );
  // }
}
