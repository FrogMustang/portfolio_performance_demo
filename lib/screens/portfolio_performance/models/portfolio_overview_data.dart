import 'package:portfolio_performance_demo/generated/portfolio_overview.pb.dart' as pb;
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';

class PortfolioOverviewData {
  final List<PortfolioWatchlistItem> items;

  PortfolioOverviewData({
    required this.items,
  });

  factory PortfolioOverviewData.fromProto(pb.PortfolioOverviewResponse proto) {
    return PortfolioOverviewData(
      items: proto.items.map((item) => PortfolioWatchlistItem.fromProto(item)).toList(),
    );
  }

  pb.PortfolioOverviewResponse toProto() {
    return pb.PortfolioOverviewResponse(
      items: items.map((item) => item.toProto()).toList(),
    );
  }
}
