// This is a generated file - do not edit.
//
// Generated from portfolio_chart.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'portfolio_chart.pb.dart' as $0;

export 'portfolio_chart.pb.dart';

/// Service definition for portfolio chart
@$pb.GrpcServiceName('portfolio.PortfolioChartService')
class PortfolioChartServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  PortfolioChartServiceClient(super.channel,
      {super.options, super.interceptors});

  /// Get portfolio chart data
  $grpc.ResponseFuture<$0.PortfolioChartResponse> getPortfolioChart(
    $0.PortfolioChartRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPortfolioChart, request, options: options);
  }

  // method descriptors

  static final _$getPortfolioChart =
      $grpc.ClientMethod<$0.PortfolioChartRequest, $0.PortfolioChartResponse>(
          '/portfolio.PortfolioChartService/GetPortfolioChart',
          ($0.PortfolioChartRequest value) => value.writeToBuffer(),
          $0.PortfolioChartResponse.fromBuffer);
}

@$pb.GrpcServiceName('portfolio.PortfolioChartService')
abstract class PortfolioChartServiceBase extends $grpc.Service {
  $core.String get $name => 'portfolio.PortfolioChartService';

  PortfolioChartServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PortfolioChartRequest,
            $0.PortfolioChartResponse>(
        'GetPortfolioChart',
        getPortfolioChart_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.PortfolioChartRequest.fromBuffer(value),
        ($0.PortfolioChartResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PortfolioChartResponse> getPortfolioChart_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PortfolioChartRequest> $request) async {
    return getPortfolioChart($call, await $request);
  }

  $async.Future<$0.PortfolioChartResponse> getPortfolioChart(
      $grpc.ServiceCall call, $0.PortfolioChartRequest request);
}
