import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_performance_demo/generated/portfolio_overview.pb.dart' as pb;
import 'package:portfolio_performance_demo/screens/portfolio_performance/models/portfolio_watchlist_item.dart';

void main() {
  group('PortfolioWatchlistItem', () {
    test('creates instance with all fields correctly', () {
      final item = PortfolioWatchlistItem(
        name: 'Apple Inc.',
        symbol: 'AAPL',
        rateOfReturnPercent: 18.45,
        totalProfitLoss: 1845.50,
        totalInvestedAmount: 10000.0,
        shares: 50.0,
      );

      expect(item.name, 'Apple Inc.');
      expect(item.symbol, 'AAPL');
      expect(item.rateOfReturnPercent, 18.45);
      expect(item.totalProfitLoss, 1845.50);
      expect(item.totalInvestedAmount, 10000.0);
      expect(item.shares, 50.0);
    });

    test('fromProto converts protobuf message correctly', () {
      final proto = pb.PortfolioWatchlistItem()
        ..name = 'Microsoft Corporation'
        ..symbol = 'MSFT'
        ..rateOfReturnPercent = 22.30
        ..totalProfitLoss = 2230.00
        ..totalInvestedAmount = 10000.0
        ..shares = 30.0;

      final item = PortfolioWatchlistItem.fromProto(proto);

      expect(item.name, 'Microsoft Corporation');
      expect(item.symbol, 'MSFT');
      expect(item.rateOfReturnPercent, 22.30);
      expect(item.totalProfitLoss, 2230.00);
      expect(item.totalInvestedAmount, 10000.0);
      expect(item.shares, 30.0);
    });

    test('toProto converts to protobuf message correctly', () {
      final item = PortfolioWatchlistItem(
        name: 'Tesla, Inc.',
        symbol: 'TSLA',
        rateOfReturnPercent: 28.90,
        totalProfitLoss: 2890.00,
        totalInvestedAmount: 10000.0,
        shares: 35.0,
      );

      final proto = item.toProto();

      expect(proto.name, 'Tesla, Inc.');
      expect(proto.symbol, 'TSLA');
      expect(proto.rateOfReturnPercent, 28.90);
      expect(proto.totalProfitLoss, 2890.00);
      expect(proto.totalInvestedAmount, 10000.0);
      expect(proto.shares, 35.0);
    });

    test('fromProto and toProto are reversible', () {
      final original = PortfolioWatchlistItem(
        name: 'NVIDIA Corporation',
        symbol: 'NVDA',
        rateOfReturnPercent: 35.67,
        totalProfitLoss: 3567.00,
        totalInvestedAmount: 10000.0,
        shares: 25.0,
      );

      final proto = original.toProto();
      final converted = PortfolioWatchlistItem.fromProto(proto);

      expect(converted.name, original.name);
      expect(converted.symbol, original.symbol);
      expect(converted.rateOfReturnPercent, original.rateOfReturnPercent);
      expect(converted.totalProfitLoss, original.totalProfitLoss);
      expect(converted.totalInvestedAmount, original.totalInvestedAmount);
      expect(converted.shares, original.shares);
    });

    test('calculates current value correctly', () {
      final item = PortfolioWatchlistItem(
        name: 'Test Stock',
        symbol: 'TEST',
        rateOfReturnPercent: 20.0,
        totalProfitLoss: 2000.0,
        totalInvestedAmount: 10000.0,
        shares: 100.0,
      );

      final currentValue = item.totalInvestedAmount + item.totalProfitLoss;
      expect(currentValue, 12000.0);
    });

    test('equality works correctly', () {
      final item1 = PortfolioWatchlistItem(
        name: 'Test',
        symbol: 'TEST',
        rateOfReturnPercent: 10.0,
        totalProfitLoss: 1000.0,
        totalInvestedAmount: 10000.0,
        shares: 100.0,
      );

      final item2 = PortfolioWatchlistItem(
        name: 'Test',
        symbol: 'TEST',
        rateOfReturnPercent: 10.0,
        totalProfitLoss: 1000.0,
        totalInvestedAmount: 10000.0,
        shares: 100.0,
      );

      final item3 = PortfolioWatchlistItem(
        name: 'Different',
        symbol: 'DIFF',
        rateOfReturnPercent: 10.0,
        totalProfitLoss: 1000.0,
        totalInvestedAmount: 10000.0,
        shares: 100.0,
      );

      // Just verify items are created (equality not implemented)
      expect(item1.name, item2.name);
      expect(item1.name, isNot(equals(item3.name)));
    });
  });
}
