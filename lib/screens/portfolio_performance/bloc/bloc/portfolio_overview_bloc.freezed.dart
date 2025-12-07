// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio_overview_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PortfolioOverviewEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioOverviewEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PortfolioOverviewEvent()';
}


}

/// @nodoc
class $PortfolioOverviewEventCopyWith<$Res>  {
$PortfolioOverviewEventCopyWith(PortfolioOverviewEvent _, $Res Function(PortfolioOverviewEvent) __);
}


/// Adds pattern-matching-related methods to [PortfolioOverviewEvent].
extension PortfolioOverviewEventPatterns on PortfolioOverviewEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _FetchPortfolioOverview value)?  fetchPortfolioOverview,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FetchPortfolioOverview() when fetchPortfolioOverview != null:
return fetchPortfolioOverview(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _FetchPortfolioOverview value)  fetchPortfolioOverview,}){
final _that = this;
switch (_that) {
case _FetchPortfolioOverview():
return fetchPortfolioOverview(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _FetchPortfolioOverview value)?  fetchPortfolioOverview,}){
final _that = this;
switch (_that) {
case _FetchPortfolioOverview() when fetchPortfolioOverview != null:
return fetchPortfolioOverview(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchPortfolioOverview,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FetchPortfolioOverview() when fetchPortfolioOverview != null:
return fetchPortfolioOverview();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchPortfolioOverview,}) {final _that = this;
switch (_that) {
case _FetchPortfolioOverview():
return fetchPortfolioOverview();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchPortfolioOverview,}) {final _that = this;
switch (_that) {
case _FetchPortfolioOverview() when fetchPortfolioOverview != null:
return fetchPortfolioOverview();case _:
  return null;

}
}

}

/// @nodoc


class _FetchPortfolioOverview implements PortfolioOverviewEvent {
  const _FetchPortfolioOverview();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchPortfolioOverview);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PortfolioOverviewEvent.fetchPortfolioOverview()';
}


}




/// @nodoc
mixin _$PortfolioOverviewState {

 FetchPortfolioOverviewStatus get status; PortfolioOverviewData? get data; String? get error;
/// Create a copy of PortfolioOverviewState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PortfolioOverviewStateCopyWith<PortfolioOverviewState> get copyWith => _$PortfolioOverviewStateCopyWithImpl<PortfolioOverviewState>(this as PortfolioOverviewState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PortfolioOverviewState&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,data,error);

@override
String toString() {
  return 'PortfolioOverviewState(status: $status, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class $PortfolioOverviewStateCopyWith<$Res>  {
  factory $PortfolioOverviewStateCopyWith(PortfolioOverviewState value, $Res Function(PortfolioOverviewState) _then) = _$PortfolioOverviewStateCopyWithImpl;
@useResult
$Res call({
 FetchPortfolioOverviewStatus status, PortfolioOverviewData? data, String? error
});




}
/// @nodoc
class _$PortfolioOverviewStateCopyWithImpl<$Res>
    implements $PortfolioOverviewStateCopyWith<$Res> {
  _$PortfolioOverviewStateCopyWithImpl(this._self, this._then);

  final PortfolioOverviewState _self;
  final $Res Function(PortfolioOverviewState) _then;

/// Create a copy of PortfolioOverviewState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FetchPortfolioOverviewStatus,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PortfolioOverviewData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PortfolioOverviewState].
extension PortfolioOverviewStatePatterns on PortfolioOverviewState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PortfolioOverviewState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PortfolioOverviewState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PortfolioOverviewState value)  $default,){
final _that = this;
switch (_that) {
case _PortfolioOverviewState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PortfolioOverviewState value)?  $default,){
final _that = this;
switch (_that) {
case _PortfolioOverviewState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FetchPortfolioOverviewStatus status,  PortfolioOverviewData? data,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PortfolioOverviewState() when $default != null:
return $default(_that.status,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FetchPortfolioOverviewStatus status,  PortfolioOverviewData? data,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PortfolioOverviewState():
return $default(_that.status,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FetchPortfolioOverviewStatus status,  PortfolioOverviewData? data,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PortfolioOverviewState() when $default != null:
return $default(_that.status,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PortfolioOverviewState implements PortfolioOverviewState {
  const _PortfolioOverviewState({this.status = FetchPortfolioOverviewStatus.initial, this.data = null, this.error = null});
  

@override@JsonKey() final  FetchPortfolioOverviewStatus status;
@override@JsonKey() final  PortfolioOverviewData? data;
@override@JsonKey() final  String? error;

/// Create a copy of PortfolioOverviewState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PortfolioOverviewStateCopyWith<_PortfolioOverviewState> get copyWith => __$PortfolioOverviewStateCopyWithImpl<_PortfolioOverviewState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PortfolioOverviewState&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,data,error);

@override
String toString() {
  return 'PortfolioOverviewState(status: $status, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PortfolioOverviewStateCopyWith<$Res> implements $PortfolioOverviewStateCopyWith<$Res> {
  factory _$PortfolioOverviewStateCopyWith(_PortfolioOverviewState value, $Res Function(_PortfolioOverviewState) _then) = __$PortfolioOverviewStateCopyWithImpl;
@override @useResult
$Res call({
 FetchPortfolioOverviewStatus status, PortfolioOverviewData? data, String? error
});




}
/// @nodoc
class __$PortfolioOverviewStateCopyWithImpl<$Res>
    implements _$PortfolioOverviewStateCopyWith<$Res> {
  __$PortfolioOverviewStateCopyWithImpl(this._self, this._then);

  final _PortfolioOverviewState _self;
  final $Res Function(_PortfolioOverviewState) _then;

/// Create a copy of PortfolioOverviewState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_PortfolioOverviewState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FetchPortfolioOverviewStatus,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PortfolioOverviewData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
