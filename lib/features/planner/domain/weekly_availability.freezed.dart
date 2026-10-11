// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeeklyAvailability {

 String get id; String get studyPlanId; int get weekday; int get totalAvailableMinutes; bool get isStudyDay; int? get preferredStartTime; int? get preferredEndTime; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of WeeklyAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyAvailabilityCopyWith<WeeklyAvailability> get copyWith => _$WeeklyAvailabilityCopyWithImpl<WeeklyAvailability>(this as WeeklyAvailability, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WeeklyAvailability;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklyAvailability&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.weekday, _this.weekday) || other.weekday == _this.weekday)&&(identical(other.totalAvailableMinutes, _this.totalAvailableMinutes) || other.totalAvailableMinutes == _this.totalAvailableMinutes)&&(identical(other.isStudyDay, _this.isStudyDay) || other.isStudyDay == _this.isStudyDay)&&(identical(other.preferredStartTime, _this.preferredStartTime) || other.preferredStartTime == _this.preferredStartTime)&&(identical(other.preferredEndTime, _this.preferredEndTime) || other.preferredEndTime == _this.preferredEndTime)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as WeeklyAvailability;
  return Object.hash(runtimeType,_this.id,_this.studyPlanId,_this.weekday,_this.totalAvailableMinutes,_this.isStudyDay,_this.preferredStartTime,_this.preferredEndTime,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as WeeklyAvailability;
  return 'WeeklyAvailability(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, weekday: ${_this.weekday}, totalAvailableMinutes: ${_this.totalAvailableMinutes}, isStudyDay: ${_this.isStudyDay}, preferredStartTime: ${_this.preferredStartTime}, preferredEndTime: ${_this.preferredEndTime}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $WeeklyAvailabilityCopyWith<$Res>  {
  factory $WeeklyAvailabilityCopyWith(WeeklyAvailability value, $Res Function(WeeklyAvailability) _then) = _$WeeklyAvailabilityCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, int weekday, int totalAvailableMinutes, bool isStudyDay, int? preferredStartTime, int? preferredEndTime, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$WeeklyAvailabilityCopyWithImpl<$Res>
    implements $WeeklyAvailabilityCopyWith<$Res> {
  _$WeeklyAvailabilityCopyWithImpl(this._self, this._then);

  final WeeklyAvailability _self;
  final $Res Function(WeeklyAvailability) _then;

/// Create a copy of WeeklyAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? weekday = null,Object? totalAvailableMinutes = null,Object? isStudyDay = null,Object? preferredStartTime = freezed,Object? preferredEndTime = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(WeeklyAvailability(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,totalAvailableMinutes: null == totalAvailableMinutes ? _self.totalAvailableMinutes : totalAvailableMinutes // ignore: cast_nullable_to_non_nullable
as int,isStudyDay: null == isStudyDay ? _self.isStudyDay : isStudyDay // ignore: cast_nullable_to_non_nullable
as bool,preferredStartTime: freezed == preferredStartTime ? _self.preferredStartTime : preferredStartTime // ignore: cast_nullable_to_non_nullable
as int?,preferredEndTime: freezed == preferredEndTime ? _self.preferredEndTime : preferredEndTime // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [WeeklyAvailability].
extension WeeklyAvailabilityPatterns on WeeklyAvailability {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeeklyAvailability value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeeklyAvailability() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeeklyAvailability value)  $default,){
final _that = this;
switch (_that) {
case _WeeklyAvailability():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeeklyAvailability value)?  $default,){
final _that = this;
switch (_that) {
case _WeeklyAvailability() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  int weekday,  int totalAvailableMinutes,  bool isStudyDay,  int? preferredStartTime,  int? preferredEndTime,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeeklyAvailability() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.weekday,_that.totalAvailableMinutes,_that.isStudyDay,_that.preferredStartTime,_that.preferredEndTime,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  int weekday,  int totalAvailableMinutes,  bool isStudyDay,  int? preferredStartTime,  int? preferredEndTime,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _WeeklyAvailability():
return $default(_that.id,_that.studyPlanId,_that.weekday,_that.totalAvailableMinutes,_that.isStudyDay,_that.preferredStartTime,_that.preferredEndTime,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  int weekday,  int totalAvailableMinutes,  bool isStudyDay,  int? preferredStartTime,  int? preferredEndTime,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _WeeklyAvailability() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.weekday,_that.totalAvailableMinutes,_that.isStudyDay,_that.preferredStartTime,_that.preferredEndTime,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _WeeklyAvailability implements WeeklyAvailability {
  const _WeeklyAvailability({required this.id, required this.studyPlanId, required this.weekday, required this.totalAvailableMinutes, required this.isStudyDay, this.preferredStartTime, this.preferredEndTime, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String studyPlanId;
@override final  int weekday;
@override final  int totalAvailableMinutes;
@override final  bool isStudyDay;
@override final  int? preferredStartTime;
@override final  int? preferredEndTime;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of WeeklyAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyAvailabilityCopyWith<_WeeklyAvailability> get copyWith => __$WeeklyAvailabilityCopyWithImpl<_WeeklyAvailability>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklyAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.totalAvailableMinutes, totalAvailableMinutes) || other.totalAvailableMinutes == totalAvailableMinutes)&&(identical(other.isStudyDay, isStudyDay) || other.isStudyDay == isStudyDay)&&(identical(other.preferredStartTime, preferredStartTime) || other.preferredStartTime == preferredStartTime)&&(identical(other.preferredEndTime, preferredEndTime) || other.preferredEndTime == preferredEndTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyPlanId,weekday,totalAvailableMinutes,isStudyDay,preferredStartTime,preferredEndTime,createdAt,updatedAt);
}

@override
String toString() {
    return 'WeeklyAvailability(id: $id, studyPlanId: $studyPlanId, weekday: $weekday, totalAvailableMinutes: $totalAvailableMinutes, isStudyDay: $isStudyDay, preferredStartTime: $preferredStartTime, preferredEndTime: $preferredEndTime, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$WeeklyAvailabilityCopyWith<$Res> implements $WeeklyAvailabilityCopyWith<$Res> {
  factory _$WeeklyAvailabilityCopyWith(_WeeklyAvailability value, $Res Function(_WeeklyAvailability) _then) = __$WeeklyAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, int weekday, int totalAvailableMinutes, bool isStudyDay, int? preferredStartTime, int? preferredEndTime, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$WeeklyAvailabilityCopyWithImpl<$Res>
    implements _$WeeklyAvailabilityCopyWith<$Res> {
  __$WeeklyAvailabilityCopyWithImpl(this._self, this._then);

  final _WeeklyAvailability _self;
  final $Res Function(_WeeklyAvailability) _then;

/// Create a copy of WeeklyAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? weekday = null,Object? totalAvailableMinutes = null,Object? isStudyDay = null,Object? preferredStartTime = freezed,Object? preferredEndTime = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_WeeklyAvailability(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,totalAvailableMinutes: null == totalAvailableMinutes ? _self.totalAvailableMinutes : totalAvailableMinutes // ignore: cast_nullable_to_non_nullable
as int,isStudyDay: null == isStudyDay ? _self.isStudyDay : isStudyDay // ignore: cast_nullable_to_non_nullable
as bool,preferredStartTime: freezed == preferredStartTime ? _self.preferredStartTime : preferredStartTime // ignore: cast_nullable_to_non_nullable
as int?,preferredEndTime: freezed == preferredEndTime ? _self.preferredEndTime : preferredEndTime // ignore: cast_nullable_to_non_nullable
as int?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
