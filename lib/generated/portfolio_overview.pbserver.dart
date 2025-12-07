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

import 'package:protobuf/protobuf.dart' as $pb;

import 'portfolio_overview.pb.dart' as $0;

export 'portfolio_overview.pb.dart';

abstract class PortfolioOverviewServiceBase extends $pb.GeneratedService {
  $async.Future<$0.PortfolioOverviewResponse> getPortfolioOverview(
      $pb.ServerContext ctx, $0.PortfolioOverviewRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetPortfolioOverview':
        return $0.PortfolioOverviewRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall(
      $pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetPortfolioOverview':
        return getPortfolioOverview(ctx, request as $0.PortfolioOverviewRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }
}
