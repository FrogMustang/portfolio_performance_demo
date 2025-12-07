import 'package:grpc/grpc.dart';
import 'package:portfolio_performance_demo/generated/portfolio_overview.pbgrpc.dart';
import 'package:portfolio_performance_demo/screens/portfolio_performance/repository/mock_portfolio_grpc_server.dart';

abstract class IPortfolioOverviewApi {
  Future<PortfolioOverviewResponse> getPortfolioOverview();

  /// Close the API connection
  Future<void> close();
}

class PortfolioOverviewApi implements IPortfolioOverviewApi {
  final PortfolioOverviewServiceClient? _client;
  final ClientChannel? _channel;
  static MockGrpcServer? _staticMockServer;
  static int? _mockServerPort;

  /// Create API with existing client (useful for testing with mock client)
  PortfolioOverviewApi.withClient(this._client) : _channel = null;

  /// Create API with channel connection
  PortfolioOverviewApi.withChannel(ClientChannel channel)
    : _channel = channel,
      _client = PortfolioOverviewServiceClient(channel);

  /// Create API with host and port
  factory PortfolioOverviewApi({
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

      return PortfolioOverviewApi.withChannel(channel);
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
    return PortfolioOverviewApi.withChannel(channel);
  }

  @override
  Future<PortfolioOverviewResponse> getPortfolioOverview() async {
    final request = PortfolioOverviewRequest();

    return await _client!.getPortfolioOverview(request);
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
