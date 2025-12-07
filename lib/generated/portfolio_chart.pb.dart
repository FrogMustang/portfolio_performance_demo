// This is a generated file - do not edit.
//
// Generated from portfolio_chart.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;
import 'package:portfolio_performance_demo/generated/google/protobuf/timestamp.pb.dart'
    as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for getting portfolio chart
class PortfolioChartRequest extends $pb.GeneratedMessage {
  factory PortfolioChartRequest({
    $core.String? timespan,
  }) {
    final result = create();
    if (timespan != null) result.timespan = timespan;
    return result;
  }

  PortfolioChartRequest._();

  factory PortfolioChartRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioChartRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioChartRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'portfolio'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'timespan')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioChartRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioChartRequest copyWith(void Function(PortfolioChartRequest) updates) =>
      super.copyWith((message) => updates(message as PortfolioChartRequest))
          as PortfolioChartRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioChartRequest create() => PortfolioChartRequest._();
  @$core.override
  PortfolioChartRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PortfolioChartRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioChartRequest>(create);
  static PortfolioChartRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get timespan => $_getSZ(0);
  @$pb.TagNumber(1)
  set timespan($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTimespan() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimespan() => $_clearField(1);
}

/// Response message that contains the portfolio chart data
class PortfolioChartResponse extends $pb.GeneratedMessage {
  factory PortfolioChartResponse({
    $core.Iterable<PortfolioChartItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  PortfolioChartResponse._();

  factory PortfolioChartResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioChartResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioChartResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'portfolio'),
      createEmptyInstance: create)
    ..pPM<PortfolioChartItem>(1, _omitFieldNames ? '' : 'items',
        subBuilder: PortfolioChartItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioChartResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioChartResponse copyWith(void Function(PortfolioChartResponse) updates) =>
      super.copyWith((message) => updates(message as PortfolioChartResponse))
          as PortfolioChartResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioChartResponse create() => PortfolioChartResponse._();
  @$core.override
  PortfolioChartResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PortfolioChartResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioChartResponse>(create);
  static PortfolioChartResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PortfolioChartItem> get items => $_getList(0);
}

/// Individual portfolio chart item
class PortfolioChartItem extends $pb.GeneratedMessage {
  factory PortfolioChartItem({
    $1.Timestamp? date,
    $core.double? amount,
    $core.double? percentTimeWeightedCumulated,
    $core.double? rateOfReturnPercent,
    $core.double? totalProfitLoss,
  }) {
    final result = create();
    if (date != null) result.date = date;
    if (amount != null) result.amount = amount;
    if (percentTimeWeightedCumulated != null)
      result.percentTimeWeightedCumulated = percentTimeWeightedCumulated;
    if (rateOfReturnPercent != null) result.rateOfReturnPercent = rateOfReturnPercent;
    if (totalProfitLoss != null) result.totalProfitLoss = totalProfitLoss;
    return result;
  }

  PortfolioChartItem._();

  factory PortfolioChartItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioChartItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioChartItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'portfolio'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'date', subBuilder: $1.Timestamp.create)
    ..aD(2, _omitFieldNames ? '' : 'amount')
    ..aD(3, _omitFieldNames ? '' : 'percentTimeWeightedCumulated')
    ..aD(4, _omitFieldNames ? '' : 'rateOfReturnPercent')
    ..aD(5, _omitFieldNames ? '' : 'totalProfitLoss')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioChartItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioChartItem copyWith(void Function(PortfolioChartItem) updates) =>
      super.copyWith((message) => updates(message as PortfolioChartItem))
          as PortfolioChartItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioChartItem create() => PortfolioChartItem._();
  @$core.override
  PortfolioChartItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PortfolioChartItem getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PortfolioChartItem>(create);
  static PortfolioChartItem? _defaultInstance;

  /// The date of the portfolio chart item
  @$pb.TagNumber(1)
  $1.Timestamp get date => $_getN(0);
  @$pb.TagNumber(1)
  set date($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureDate() => $_ensure(0);

  /// The amount of the portfolio chart item
  @$pb.TagNumber(2)
  $core.double get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  /// The cumulative time-weighted performance of the portfolio in percent (%) over the performance period
  @$pb.TagNumber(3)
  $core.double get percentTimeWeightedCumulated => $_getN(2);
  @$pb.TagNumber(3)
  set percentTimeWeightedCumulated($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPercentTimeWeightedCumulated() => $_has(2);
  @$pb.TagNumber(3)
  void clearPercentTimeWeightedCumulated() => $_clearField(3);

  /// The rate of return percentage generated until that point in time.
  @$pb.TagNumber(4)
  $core.double get rateOfReturnPercent => $_getN(3);
  @$pb.TagNumber(4)
  set rateOfReturnPercent($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRateOfReturnPercent() => $_has(3);
  @$pb.TagNumber(4)
  void clearRateOfReturnPercent() => $_clearField(4);

  /// The total profit or loss amount (positive for profit, negative for loss) made until that point in time.
  @$pb.TagNumber(5)
  $core.double get totalProfitLoss => $_getN(4);
  @$pb.TagNumber(5)
  set totalProfitLoss($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalProfitLoss() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalProfitLoss() => $_clearField(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
