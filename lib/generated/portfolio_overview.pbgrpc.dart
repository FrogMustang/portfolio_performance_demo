// This is a generated file - do not edit.
//
// Generated from portfolio_overview.proto.

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

import 'portfolio_overview.pb.dart' as $0;

export 'portfolio_overview.pb.dart';

/// Service definition for portfolio overview
@$pb.GrpcServiceName('portfolio.PortfolioOverviewService')
class PortfolioOverviewServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  PortfolioOverviewServiceClient(super.channel, {super.options, super.interceptors});

  /// Get portfolio overview data
  $grpc.ResponseFuture<$0.PortfolioOverviewResponse> getPortfolioOverview(
    $0.PortfolioOverviewRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getPortfolioOverview, request, options: options);
  }

  // method descriptors

  static final _$getPortfolioOverview =
      $grpc.ClientMethod<$0.PortfolioOverviewRequest, $0.PortfolioOverviewResponse>(
          '/portfolio.PortfolioOverviewService/GetPortfolioOverview',
          ($0.PortfolioOverviewRequest value) => value.writeToBuffer(),
          $0.PortfolioOverviewResponse.fromBuffer);
}

@$pb.GrpcServiceName('portfolio.PortfolioOverviewService')
abstract class PortfolioOverviewServiceBase extends $grpc.Service {
  $core.String get $name => 'portfolio.PortfolioOverviewService';

  PortfolioOverviewServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.PortfolioOverviewRequest, $0.PortfolioOverviewResponse>(
            'GetPortfolioOverview',
            getPortfolioOverview_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.PortfolioOverviewRequest.fromBuffer(value),
            ($0.PortfolioOverviewResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PortfolioOverviewResponse> getPortfolioOverview_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.PortfolioOverviewRequest> $request) async {
    return getPortfolioOverview($call, await $request);
  }

  $async.Future<$0.PortfolioOverviewResponse> getPortfolioOverview(
      $grpc.ServiceCall call, $0.PortfolioOverviewRequest request);
}
