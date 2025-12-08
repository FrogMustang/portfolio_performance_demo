import 'package:grpc/grpc.dart';
import 'package:portfolio_performance_demo/generated/portfolio_chart.pbgrpc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/mock_portfolio_grpc_server.dart';

abstract class IPortfolioChartApi {
  Future<PortfolioChartResponse> getPortfolioChart({
    String? timespan,
  });

  /// Close the API connection
  Future<void> close();
}

class PortfolioChartApi implements IPortfolioChartApi {
  final PortfolioChartServiceClient? _client;
  final ClientChannel? _channel;
  static MockGrpcServer? _staticMockServer;
  static int? _mockServerPort;

  /// Create API with channel connection
  PortfolioChartApi.withChannel(ClientChannel channel)
    : _channel = channel,
      _client = PortfolioChartServiceClient(channel);

  /// Create API with host and port
  factory PortfolioChartApi({
    required String host,
    required int port,
    bool secure = true,
    bool useMockData = false,
  }) {
    if (useMockData) {
      if (_mockServerPort == null) {
        throw StateError('Mock gRPC server is not initialized');
      }

      final channel = ClientChannel(
        'localhost',
        port: _mockServerPort!,
        options: const ChannelOptions(
          credentials: ChannelCredentials.insecure(),
        ),
      );

      return PortfolioChartApi.withChannel(channel);
    }

    final channel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: secure
            ? const ChannelCredentials.secure()
            : const ChannelCredentials.insecure(),
      ),
    );
    return PortfolioChartApi.withChannel(channel);
  }

  @override
  Future<PortfolioChartResponse> getPortfolioChart({
    String? timespan,
  }) async {
    final request = PortfolioChartRequest(
      timespan: timespan ?? '',
    );

    return await _client!.getPortfolioChart(request);
  }

  @override
  Future<void> close() async {
    await _channel?.shutdown();
  }

  /// Initialize the mock server
  static Future<void> initializeMockServer() async {
    if (_staticMockServer == null) {
      _staticMockServer = MockGrpcServer.instance;
      await _staticMockServer!.start();
      _mockServerPort = _staticMockServer!.port;
    }
  }

  /// Stop the mock server
  static Future<void> stopMockServer() async {
    if (_staticMockServer != null) {
      await _staticMockServer!.stop();
    }
    _staticMockServer = null;
    _mockServerPort = null;
  }
}
