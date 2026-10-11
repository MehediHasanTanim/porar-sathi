// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarException {

 String get id; String get studyPlanId; DateTime get date; CalendarExceptionType get exceptionType; int? get availableMinutesOverride; String? get reason; bool get isNoStudyDay; DateTime get createdAt;
/// Create a copy of CalendarException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CalendarExceptionCopyWith<CalendarException> get copyWith => _$CalendarExceptionCopyWithImpl<CalendarException>(this as CalendarException, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CalendarException;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarException&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.exceptionType, _this.exceptionType) || other.exceptionType == _this.exceptionType)&&(identical(other.availableMinutesOverride, _this.availableMinutesOverride) || other.availableMinutesOverride == _this.availableMinutesOverride)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.isNoStudyDay, _this.isNoStudyDay) || other.isNoStudyDay == _this.isNoStudyDay)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as CalendarException;
  return Object.hash(runtimeType,_this.id,_this.studyPlanId,_this.date,_this.exceptionType,_this.availableMinutesOverride,_this.reason,_this.isNoStudyDay,_this.createdAt);
}

@override
String toString() {
  final _this = this as CalendarException;
  return 'CalendarException(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, date: ${_this.date}, exceptionType: ${_this.exceptionType}, availableMinutesOverride: ${_this.availableMinutesOverride}, reason: ${_this.reason}, isNoStudyDay: ${_this.isNoStudyDay}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $CalendarExceptionCopyWith<$Res>  {
  factory $CalendarExceptionCopyWith(CalendarException value, $Res Function(CalendarException) _then) = _$CalendarExceptionCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, DateTime date, CalendarExceptionType exceptionType, int? availableMinutesOverride, String? reason, bool isNoStudyDay, DateTime createdAt
});




}
/// @nodoc
class _$CalendarExceptionCopyWithImpl<$Res>
    implements $CalendarExceptionCopyWith<$Res> {
  _$CalendarExceptionCopyWithImpl(this._self, this._then);

  final CalendarException _self;
  final $Res Function(CalendarException) _then;

/// Create a copy of CalendarException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? date = null,Object? exceptionType = null,Object? availableMinutesOverride = freezed,Object? reason = freezed,Object? isNoStudyDay = null,Object? createdAt = null,}) {
  return _then(CalendarException(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,exceptionType: null == exceptionType ? _self.exceptionType : exceptionType // ignore: cast_nullable_to_non_nullable
as CalendarExceptionType,availableMinutesOverride: freezed == availableMinutesOverride ? _self.availableMinutesOverride : availableMinutesOverride // ignore: cast_nullable_to_non_nullable
as int?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isNoStudyDay: null == isNoStudyDay ? _self.isNoStudyDay : isNoStudyDay // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CalendarException].
extension CalendarExceptionPatterns on CalendarException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarException value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarException() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarException value)  $default,){
final _that = this;
switch (_that) {
case _CalendarException():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarException value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarException() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  DateTime date,  CalendarExceptionType exceptionType,  int? availableMinutesOverride,  String? reason,  bool isNoStudyDay,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarException() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.date,_that.exceptionType,_that.availableMinutesOverride,_that.reason,_that.isNoStudyDay,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  DateTime date,  CalendarExceptionType exceptionType,  int? availableMinutesOverride,  String? reason,  bool isNoStudyDay,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _CalendarException():
return $default(_that.id,_that.studyPlanId,_that.date,_that.exceptionType,_that.availableMinutesOverride,_that.reason,_that.isNoStudyDay,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  DateTime date,  CalendarExceptionType exceptionType,  int? availableMinutesOverride,  String? reason,  bool isNoStudyDay,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _CalendarException() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.date,_that.exceptionType,_that.availableMinutesOverride,_that.reason,_that.isNoStudyDay,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarException implements CalendarException {
  const _CalendarException({required this.id, required this.studyPlanId, required this.date, required this.exceptionType, this.availableMinutesOverride, this.reason, required this.isNoStudyDay, required this.createdAt});
  

@override final  String id;
@override final  String studyPlanId;
@override final  DateTime date;
@override final  CalendarExceptionType exceptionType;
@override final  int? availableMinutesOverride;
@override final  String? reason;
@override final  bool isNoStudyDay;
@override final  DateTime createdAt;

/// Create a copy of CalendarException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CalendarExceptionCopyWith<_CalendarException> get copyWith => __$CalendarExceptionCopyWithImpl<_CalendarException>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarException&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.date, date) || other.date == date)&&(identical(other.exceptionType, exceptionType) || other.exceptionType == exceptionType)&&(identical(other.availableMinutesOverride, availableMinutesOverride) || other.availableMinutesOverride == availableMinutesOverride)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isNoStudyDay, isNoStudyDay) || other.isNoStudyDay == isNoStudyDay)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyPlanId,date,exceptionType,availableMinutesOverride,reason,isNoStudyDay,createdAt);
}

@override
String toString() {
    return 'CalendarException(id: $id, studyPlanId: $studyPlanId, date: $date, exceptionType: $exceptionType, availableMinutesOverride: $availableMinutesOverride, reason: $reason, isNoStudyDay: $isNoStudyDay, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$CalendarExceptionCopyWith<$Res> implements $CalendarExceptionCopyWith<$Res> {
  factory _$CalendarExceptionCopyWith(_CalendarException value, $Res Function(_CalendarException) _then) = __$CalendarExceptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, DateTime date, CalendarExceptionType exceptionType, int? availableMinutesOverride, String? reason, bool isNoStudyDay, DateTime createdAt
});




}
/// @nodoc
class __$CalendarExceptionCopyWithImpl<$Res>
    implements _$CalendarExceptionCopyWith<$Res> {
  __$CalendarExceptionCopyWithImpl(this._self, this._then);

  final _CalendarException _self;
  final $Res Function(_CalendarException) _then;

/// Create a copy of CalendarException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? date = null,Object? exceptionType = null,Object? availableMinutesOverride = freezed,Object? reason = freezed,Object? isNoStudyDay = null,Object? createdAt = null,}) {
  return _then(_CalendarException(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,exceptionType: null == exceptionType ? _self.exceptionType : exceptionType // ignore: cast_nullable_to_non_nullable
as CalendarExceptionType,availableMinutesOverride: freezed == availableMinutesOverride ? _self.availableMinutesOverride : availableMinutesOverride // ignore: cast_nullable_to_non_nullable
as int?,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isNoStudyDay: null == isNoStudyDay ? _self.isNoStudyDay : isNoStudyDay // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
