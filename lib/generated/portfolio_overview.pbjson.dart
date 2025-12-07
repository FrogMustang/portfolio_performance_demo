// This is a generated file - do not edit.
//
// Generated from portfolio_overview.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use portfolioOverviewRequestDescriptor instead')
const PortfolioOverviewRequest$json = {
  '1': 'PortfolioOverviewRequest',
};

/// Descriptor for `PortfolioOverviewRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioOverviewRequestDescriptor =
    $convert.base64Decode('ChhQb3J0Zm9saW9PdmVydmlld1JlcXVlc3Q=');

@$core.Deprecated('Use portfolioOverviewResponseDescriptor instead')
const PortfolioOverviewResponse$json = {
  '1': 'PortfolioOverviewResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.portfolio.PortfolioWatchlistItem',
      '10': 'items'
    },
  ],
};

/// Descriptor for `PortfolioOverviewResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioOverviewResponseDescriptor = $convert.base64Decode(
    'ChlQb3J0Zm9saW9PdmVydmlld1Jlc3BvbnNlEjcKBWl0ZW1zGAEgAygLMiEucG9ydGZvbGlvLl'
    'BvcnRmb2xpb1dhdGNobGlzdEl0ZW1SBWl0ZW1z');

@$core.Deprecated('Use portfolioWatchlistItemDescriptor instead')
const PortfolioWatchlistItem$json = {
  '1': 'PortfolioWatchlistItem',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'symbol', '3': 2, '4': 1, '5': 9, '10': 'symbol'},
    {'1': 'rate_of_return_percent', '3': 3, '4': 1, '5': 1, '10': 'rateOfReturnPercent'},
    {'1': 'total_profit_loss', '3': 4, '4': 1, '5': 1, '10': 'totalProfitLoss'},
    {'1': 'total_invested_amount', '3': 5, '4': 1, '5': 1, '10': 'totalInvestedAmount'},
    {'1': 'shares', '3': 6, '4': 1, '5': 1, '10': 'shares'},
  ],
};

/// Descriptor for `PortfolioWatchlistItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioWatchlistItemDescriptor = $convert.base64Decode(
    'ChZQb3J0Zm9saW9XYXRjaGxpc3RJdGVtEhIKBG5hbWUYASABKAlSBG5hbWUSFgoGc3ltYm9sGA'
    'IgASgJUgZzeW1ib2wSMwoWcmF0ZV9vZl9yZXR1cm5fcGVyY2VudBgDIAEoAVITcmF0ZU9mUmV0'
    'dXJuUGVyY2VudBIqChF0b3RhbF9wcm9maXRfbG9zcxgEIAEoAVIPdG90YWxQcm9maXRMb3NzEj'
    'IKFXRvdGFsX2ludmVzdGVkX2Ftb3VudBgFIAEoAVITdG90YWxJbnZlc3RlZEFtb3VudBIWCgZz'
    'aGFyZXMYBiABKAFSBnNoYXJlcw==');
