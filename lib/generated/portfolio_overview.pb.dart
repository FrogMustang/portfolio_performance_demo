// This is a generated file - do not edit.
//
// Generated from portfolio_overview.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Request message for getting portfolio overview
class PortfolioOverviewRequest extends $pb.GeneratedMessage {
  factory PortfolioOverviewRequest() => create();

  PortfolioOverviewRequest._();

  factory PortfolioOverviewRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioOverviewRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioOverviewRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'portfolio'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioOverviewRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioOverviewRequest copyWith(void Function(PortfolioOverviewRequest) updates) =>
      super.copyWith((message) => updates(message as PortfolioOverviewRequest))
          as PortfolioOverviewRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioOverviewRequest create() => PortfolioOverviewRequest._();
  @$core.override
  PortfolioOverviewRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PortfolioOverviewRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioOverviewRequest>(create);
  static PortfolioOverviewRequest? _defaultInstance;
}

/// Response message that contains the portfolio overview data
class PortfolioOverviewResponse extends $pb.GeneratedMessage {
  factory PortfolioOverviewResponse({
    $core.Iterable<PortfolioWatchlistItem>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  PortfolioOverviewResponse._();

  factory PortfolioOverviewResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioOverviewResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioOverviewResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'portfolio'),
      createEmptyInstance: create)
    ..pPM<PortfolioWatchlistItem>(1, _omitFieldNames ? '' : 'items',
        subBuilder: PortfolioWatchlistItem.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioOverviewResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioOverviewResponse copyWith(void Function(PortfolioOverviewResponse) updates) =>
      super.copyWith((message) => updates(message as PortfolioOverviewResponse))
          as PortfolioOverviewResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioOverviewResponse create() => PortfolioOverviewResponse._();
  @$core.override
  PortfolioOverviewResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PortfolioOverviewResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioOverviewResponse>(create);
  static PortfolioOverviewResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PortfolioWatchlistItem> get items => $_getList(0);
}

/// Individual portfolio watchlist item
class PortfolioWatchlistItem extends $pb.GeneratedMessage {
  factory PortfolioWatchlistItem({
    $core.String? name,
    $core.String? symbol,
    $core.double? rateOfReturnPercent,
    $core.double? totalProfitLoss,
    $core.double? totalInvestedAmount,
    $core.double? shares,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (symbol != null) result.symbol = symbol;
    if (rateOfReturnPercent != null) result.rateOfReturnPercent = rateOfReturnPercent;
    if (totalProfitLoss != null) result.totalProfitLoss = totalProfitLoss;
    if (totalInvestedAmount != null) result.totalInvestedAmount = totalInvestedAmount;
    if (shares != null) result.shares = shares;
    return result;
  }

  PortfolioWatchlistItem._();

  factory PortfolioWatchlistItem.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PortfolioWatchlistItem.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PortfolioWatchlistItem',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'portfolio'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'symbol')
    ..aD(3, _omitFieldNames ? '' : 'rateOfReturnPercent')
    ..aD(4, _omitFieldNames ? '' : 'totalProfitLoss')
    ..aD(5, _omitFieldNames ? '' : 'totalInvestedAmount')
    ..aD(6, _omitFieldNames ? '' : 'shares')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioWatchlistItem clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PortfolioWatchlistItem copyWith(void Function(PortfolioWatchlistItem) updates) =>
      super.copyWith((message) => updates(message as PortfolioWatchlistItem))
          as PortfolioWatchlistItem;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PortfolioWatchlistItem create() => PortfolioWatchlistItem._();
  @$core.override
  PortfolioWatchlistItem createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PortfolioWatchlistItem getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PortfolioWatchlistItem>(create);
  static PortfolioWatchlistItem? _defaultInstance;

  /// The name of the asset
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// The ticker symbol of the asset
  @$pb.TagNumber(2)
  $core.String get symbol => $_getSZ(1);
  @$pb.TagNumber(2)
  set symbol($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSymbol() => $_has(1);
  @$pb.TagNumber(2)
  void clearSymbol() => $_clearField(2);

  /// The rate of return percentage
  @$pb.TagNumber(3)
  $core.double get rateOfReturnPercent => $_getN(2);
  @$pb.TagNumber(3)
  set rateOfReturnPercent($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRateOfReturnPercent() => $_has(2);
  @$pb.TagNumber(3)
  void clearRateOfReturnPercent() => $_clearField(3);

  /// The total profit or loss amount (positive for profit, negative for loss)
  @$pb.TagNumber(4)
  $core.double get totalProfitLoss => $_getN(3);
  @$pb.TagNumber(4)
  set totalProfitLoss($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTotalProfitLoss() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalProfitLoss() => $_clearField(4);

  /// The total amount of money invested in this asset
  @$pb.TagNumber(5)
  $core.double get totalInvestedAmount => $_getN(4);
  @$pb.TagNumber(5)
  set totalInvestedAmount($core.double value) => $_setDouble(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalInvestedAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalInvestedAmount() => $_clearField(5);

  /// The number of shares currently owned
  @$pb.TagNumber(6)
  $core.double get shares => $_getN(5);
  @$pb.TagNumber(6)
  set shares($core.double value) => $_setDouble(5, value);
  @$pb.TagNumber(6)
  $core.bool hasShares() => $_has(5);
  @$pb.TagNumber(6)
  void clearShares() => $_clearField(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
