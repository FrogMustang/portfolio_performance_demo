// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_performance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PortfolioPerformanceEvent {

 PortfolioChartTimespan get timespan;
/// Create a copy of PortfolioPerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioPerformanceEventCopyWith<PortfolioPerformanceEvent> get copyWith => _$PortfolioPerformanceEventCopyWithImpl<PortfolioPerformanceEvent>(this as PortfolioPerformanceEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioPerformanceEvent&&(identical(other.timespan, timespan) || other.timespan == timespan));
}


@override
int get hashCode => Object.hash(runtimeType,timespan);

@override
String toString() {
  return 'PortfolioPerformanceEvent(timespan: $timespan)';
}


}

/// @nodoc
abstract mixin class $PortfolioPerformanceEventCopyWith<$Res>  {
  factory $PortfolioPerformanceEventCopyWith(PortfolioPerformanceEvent value, $Res Function(PortfolioPerformanceEvent) _then) = _$PortfolioPerformanceEventCopyWithImpl;
@useResult
$Res call({
 PortfolioChartTimespan timespan
});




}
/// @nodoc
class _$PortfolioPerformanceEventCopyWithImpl<$Res>
    implements $PortfolioPerformanceEventCopyWith<$Res> {
  _$PortfolioPerformanceEventCopyWithImpl(this._self, this._then);

  final PortfolioPerformanceEvent _self;
  final $Res Function(PortfolioPerformanceEvent) _then;

/// Create a copy of PortfolioPerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timespan = null,}) {
  return _then(_self.copyWith(
timespan: null == timespan ? _self.timespan : timespan // ignore: cast_nullable_to_non_nullable
as PortfolioChartTimespan,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioPerformanceEvent].
extension PortfolioPerformanceEventPatterns on PortfolioPerformanceEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchPortfolioChart value)?  fetchPortfolioChart,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchPortfolioChart() when fetchPortfolioChart != null:
return fetchPortfolioChart(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchPortfolioChart value)  fetchPortfolioChart,}){
final _that = this;
switch (_that) {
case _FetchPortfolioChart():
return fetchPortfolioChart(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchPortfolioChart value)?  fetchPortfolioChart,}){
final _that = this;
switch (_that) {
case _FetchPortfolioChart() when fetchPortfolioChart != null:
return fetchPortfolioChart(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PortfolioChartTimespan timespan)?  fetchPortfolioChart,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchPortfolioChart() when fetchPortfolioChart != null:
return fetchPortfolioChart(_that.timespan);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PortfolioChartTimespan timespan)  fetchPortfolioChart,}) {final _that = this;
switch (_that) {
case _FetchPortfolioChart():
return fetchPortfolioChart(_that.timespan);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PortfolioChartTimespan timespan)?  fetchPortfolioChart,}) {final _that = this;
switch (_that) {
case _FetchPortfolioChart() when fetchPortfolioChart != null:
return fetchPortfolioChart(_that.timespan);case _:
  return null;

}
}

}

/// @nodoc


class _FetchPortfolioChart implements PortfolioPerformanceEvent {
  const _FetchPortfolioChart({required this.timespan});
  

@override final  PortfolioChartTimespan timespan;

/// Create a copy of PortfolioPerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchPortfolioChartCopyWith<_FetchPortfolioChart> get copyWith => __$FetchPortfolioChartCopyWithImpl<_FetchPortfolioChart>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchPortfolioChart&&(identical(other.timespan, timespan) || other.timespan == timespan));
}


@override
int get hashCode => Object.hash(runtimeType,timespan);

@override
String toString() {
  return 'PortfolioPerformanceEvent.fetchPortfolioChart(timespan: $timespan)';
}


}

/// @nodoc
abstract mixin class _$FetchPortfolioChartCopyWith<$Res> implements $PortfolioPerformanceEventCopyWith<$Res> {
  factory _$FetchPortfolioChartCopyWith(_FetchPortfolioChart value, $Res Function(_FetchPortfolioChart) _then) = __$FetchPortfolioChartCopyWithImpl;
@override @useResult
$Res call({
 PortfolioChartTimespan timespan
});




}
/// @nodoc
class __$FetchPortfolioChartCopyWithImpl<$Res>
    implements _$FetchPortfolioChartCopyWith<$Res> {
  __$FetchPortfolioChartCopyWithImpl(this._self, this._then);

  final _FetchPortfolioChart _self;
  final $Res Function(_FetchPortfolioChart) _then;

/// Create a copy of PortfolioPerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timespan = null,}) {
  return _then(_FetchPortfolioChart(
timespan: null == timespan ? _self.timespan : timespan // ignore: cast_nullable_to_non_nullable
as PortfolioChartTimespan,
  ));
}


}

/// @nodoc
mixin _$PortfolioPerformanceState {

 PortfolioChartTimespan get timespan; FetchPortfolioChartStatus get fetchPortfolioChartStatus; PortfolioChartData? get portfolioChartData; String? get error;
/// Create a copy of PortfolioPerformanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioPerformanceStateCopyWith<PortfolioPerformanceState> get copyWith => _$PortfolioPerformanceStateCopyWithImpl<PortfolioPerformanceState>(this as PortfolioPerformanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioPerformanceState&&(identical(other.timespan, timespan) || other.timespan == timespan)&&(identical(other.fetchPortfolioChartStatus, fetchPortfolioChartStatus) || other.fetchPortfolioChartStatus == fetchPortfolioChartStatus)&&(identical(other.portfolioChartData, portfolioChartData) || other.portfolioChartData == portfolioChartData)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,timespan,fetchPortfolioChartStatus,portfolioChartData,error);

@override
String toString() {
  return 'PortfolioPerformanceState(timespan: $timespan, fetchPortfolioChartStatus: $fetchPortfolioChartStatus, portfolioChartData: $portfolioChartData, error: $error)';
}


}

/// @nodoc
abstract mixin class $PortfolioPerformanceStateCopyWith<$Res>  {
  factory $PortfolioPerformanceStateCopyWith(PortfolioPerformanceState value, $Res Function(PortfolioPerformanceState) _then) = _$PortfolioPerformanceStateCopyWithImpl;
@useResult
$Res call({
 PortfolioChartTimespan timespan, FetchPortfolioChartStatus fetchPortfolioChartStatus, PortfolioChartData? portfolioChartData, String? error
});




}
/// @nodoc
class _$PortfolioPerformanceStateCopyWithImpl<$Res>
    implements $PortfolioPerformanceStateCopyWith<$Res> {
  _$PortfolioPerformanceStateCopyWithImpl(this._self, this._then);

  final PortfolioPerformanceState _self;
  final $Res Function(PortfolioPerformanceState) _then;

/// Create a copy of PortfolioPerformanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timespan = null,Object? fetchPortfolioChartStatus = null,Object? portfolioChartData = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
timespan: null == timespan ? _self.timespan : timespan // ignore: cast_nullable_to_non_nullable
as PortfolioChartTimespan,fetchPortfolioChartStatus: null == fetchPortfolioChartStatus ? _self.fetchPortfolioChartStatus : fetchPortfolioChartStatus // ignore: cast_nullable_to_non_nullable
as FetchPortfolioChartStatus,portfolioChartData: freezed == portfolioChartData ? _self.portfolioChartData : portfolioChartData // ignore: cast_nullable_to_non_nullable
as PortfolioChartData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioPerformanceState].
extension PortfolioPerformanceStatePatterns on PortfolioPerformanceState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioPerformanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioPerformanceState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioPerformanceState value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioPerformanceState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioPerformanceState value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioPerformanceState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PortfolioChartTimespan timespan,  FetchPortfolioChartStatus fetchPortfolioChartStatus,  PortfolioChartData? portfolioChartData,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioPerformanceState() when $default != null:
return $default(_that.timespan,_that.fetchPortfolioChartStatus,_that.portfolioChartData,_that.error);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PortfolioChartTimespan timespan,  FetchPortfolioChartStatus fetchPortfolioChartStatus,  PortfolioChartData? portfolioChartData,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PortfolioPerformanceState():
return $default(_that.timespan,_that.fetchPortfolioChartStatus,_that.portfolioChartData,_that.error);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PortfolioChartTimespan timespan,  FetchPortfolioChartStatus fetchPortfolioChartStatus,  PortfolioChartData? portfolioChartData,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioPerformanceState() when $default != null:
return $default(_that.timespan,_that.fetchPortfolioChartStatus,_that.portfolioChartData,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PortfolioPerformanceState implements PortfolioPerformanceState {
  const _PortfolioPerformanceState({this.timespan = PortfolioChartTimespan.day, this.fetchPortfolioChartStatus = FetchPortfolioChartStatus.initial, this.portfolioChartData = null, this.error = null});
  

@override@JsonKey() final  PortfolioChartTimespan timespan;
@override@JsonKey() final  FetchPortfolioChartStatus fetchPortfolioChartStatus;
@override@JsonKey() final  PortfolioChartData? portfolioChartData;
@override@JsonKey() final  String? error;

/// Create a copy of PortfolioPerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioPerformanceStateCopyWith<_PortfolioPerformanceState> get copyWith => __$PortfolioPerformanceStateCopyWithImpl<_PortfolioPerformanceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioPerformanceState&&(identical(other.timespan, timespan) || other.timespan == timespan)&&(identical(other.fetchPortfolioChartStatus, fetchPortfolioChartStatus) || other.fetchPortfolioChartStatus == fetchPortfolioChartStatus)&&(identical(other.portfolioChartData, portfolioChartData) || other.portfolioChartData == portfolioChartData)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,timespan,fetchPortfolioChartStatus,portfolioChartData,error);

@override
String toString() {
  return 'PortfolioPerformanceState(timespan: $timespan, fetchPortfolioChartStatus: $fetchPortfolioChartStatus, portfolioChartData: $portfolioChartData, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PortfolioPerformanceStateCopyWith<$Res> implements $PortfolioPerformanceStateCopyWith<$Res> {
  factory _$PortfolioPerformanceStateCopyWith(_PortfolioPerformanceState value, $Res Function(_PortfolioPerformanceState) _then) = __$PortfolioPerformanceStateCopyWithImpl;
@override @useResult
$Res call({
 PortfolioChartTimespan timespan, FetchPortfolioChartStatus fetchPortfolioChartStatus, PortfolioChartData? portfolioChartData, String? error
});




}
/// @nodoc
class __$PortfolioPerformanceStateCopyWithImpl<$Res>
    implements _$PortfolioPerformanceStateCopyWith<$Res> {
  __$PortfolioPerformanceStateCopyWithImpl(this._self, this._then);

  final _PortfolioPerformanceState _self;
  final $Res Function(_PortfolioPerformanceState) _then;

/// Create a copy of PortfolioPerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timespan = null,Object? fetchPortfolioChartStatus = null,Object? portfolioChartData = freezed,Object? error = freezed,}) {
  return _then(_PortfolioPerformanceState(
timespan: null == timespan ? _self.timespan : timespan // ignore: cast_nullable_to_non_nullable
as PortfolioChartTimespan,fetchPortfolioChartStatus: null == fetchPortfolioChartStatus ? _self.fetchPortfolioChartStatus : fetchPortfolioChartStatus // ignore: cast_nullable_to_non_nullable
as FetchPortfolioChartStatus,portfolioChartData: freezed == portfolioChartData ? _self.portfolioChartData : portfolioChartData // ignore: cast_nullable_to_non_nullable
as PortfolioChartData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
