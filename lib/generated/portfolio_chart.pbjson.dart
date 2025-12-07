// This is a generated file - do not edit.
//
// Generated from portfolio_chart.proto.

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

@$core.Deprecated('Use portfolioChartRequestDescriptor instead')
const PortfolioChartRequest$json = {
  '1': 'PortfolioChartRequest',
  '2': [
    {
      '1': 'timespan',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'timespan',
      '17': true
    },
  ],
  '8': [
    {'1': '_timespan'},
  ],
};

/// Descriptor for `PortfolioChartRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioChartRequestDescriptor = $convert.base64Decode(
    'ChVQb3J0Zm9saW9DaGFydFJlcXVlc3QSHwoIdGltZXNwYW4YASABKAlIAFIIdGltZXNwYW6IAQ'
    'FCCwoJX3RpbWVzcGFu');

@$core.Deprecated('Use portfolioChartResponseDescriptor instead')
const PortfolioChartResponse$json = {
  '1': 'PortfolioChartResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.portfolio.PortfolioChartItem',
      '10': 'items'
    },
  ],
};

/// Descriptor for `PortfolioChartResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioChartResponseDescriptor =
    $convert.base64Decode(
        'ChZQb3J0Zm9saW9DaGFydFJlc3BvbnNlEjMKBWl0ZW1zGAEgAygLMh0ucG9ydGZvbGlvLlBvcn'
        'Rmb2xpb0NoYXJ0SXRlbVIFaXRlbXM=');

@$core.Deprecated('Use portfolioChartItemDescriptor instead')
const PortfolioChartItem$json = {
  '1': 'PortfolioChartItem',
  '2': [
    {
      '1': 'date',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'date'
    },
    {'1': 'amount', '3': 2, '4': 1, '5': 1, '10': 'amount'},
    {
      '1': 'percent_time_weighted_cumulated',
      '3': 3,
      '4': 1,
      '5': 1,
      '10': 'percentTimeWeightedCumulated'
    },
    {
      '1': 'rate_of_return_percent',
      '3': 4,
      '4': 1,
      '5': 1,
      '10': 'rateOfReturnPercent'
    },
    {'1': 'total_profit_loss', '3': 5, '4': 1, '5': 1, '10': 'totalProfitLoss'},
  ],
};

/// Descriptor for `PortfolioChartItem`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List portfolioChartItemDescriptor = $convert.base64Decode(
    'ChJQb3J0Zm9saW9DaGFydEl0ZW0SLgoEZGF0ZRgBIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW'
    '1lc3RhbXBSBGRhdGUSFgoGYW1vdW50GAIgASgBUgZhbW91bnQSRQofcGVyY2VudF90aW1lX3dl'
    'aWdodGVkX2N1bXVsYXRlZBgDIAEoAVIccGVyY2VudFRpbWVXZWlnaHRlZEN1bXVsYXRlZBIzCh'
    'ZyYXRlX29mX3JldHVybl9wZXJjZW50GAQgASgBUhNyYXRlT2ZSZXR1cm5QZXJjZW50EioKEXRv'
    'dGFsX3Byb2ZpdF9sb3NzGAUgASgBUg90b3RhbFByb2ZpdExvc3M=');
