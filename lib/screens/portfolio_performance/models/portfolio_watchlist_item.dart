import 'package:portfolio_performance_demo/generated/portfolio_overview.pb.dart' as pb;

class PortfolioWatchlistItem {
  final String name;
  final String symbol;
  final double rateOfReturnPercent;
  final double totalProfitLoss;
  final double totalInvestedAmount;
  final double shares;

  PortfolioWatchlistItem({
    required this.name,
    required this.symbol,
    required this.rateOfReturnPercent,
    required this.totalProfitLoss,
    required this.totalInvestedAmount,
    required this.shares,
  });

  factory PortfolioWatchlistItem.fromProto(pb.PortfolioWatchlistItem proto) {
    return PortfolioWatchlistItem(
      name: proto.name,
      symbol: proto.symbol,
      rateOfReturnPercent: proto.rateOfReturnPercent,
      totalProfitLoss: proto.totalProfitLoss,
      totalInvestedAmount: proto.totalInvestedAmount,
      shares: proto.shares,
    );
  }

  pb.PortfolioWatchlistItem toProto() {
    return pb.PortfolioWatchlistItem(
      name: name,
      symbol: symbol,
      rateOfReturnPercent: rateOfReturnPercent,
      totalProfitLoss: totalProfitLoss,
      totalInvestedAmount: totalInvestedAmount,
      shares: shares,
    );
  }
}
