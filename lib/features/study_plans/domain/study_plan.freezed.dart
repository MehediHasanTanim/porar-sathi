// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyPlan {

 String get id; String get name; String? get description; PlanType get planType; StudyPlanStatus get status; DateTime get startDate; DateTime? get targetEndDate; String? get primaryExamId; PlanningMode get planningMode; DailyIntensity get dailyIntensity; int get maxDailyMinutes; int get maxSessionMinutes; int get planningBufferPercent; int get revisionBufferDays; DateTime get createdAt; DateTime get updatedAt; DateTime? get archivedAt;
/// Create a copy of StudyPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyPlanCopyWith<StudyPlan> get copyWith => _$StudyPlanCopyWithImpl<StudyPlan>(this as StudyPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyPlan&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.planType, _this.planType) || other.planType == _this.planType)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.targetEndDate, _this.targetEndDate) || other.targetEndDate == _this.targetEndDate)&&(identical(other.primaryExamId, _this.primaryExamId) || other.primaryExamId == _this.primaryExamId)&&(identical(other.planningMode, _this.planningMode) || other.planningMode == _this.planningMode)&&(identical(other.dailyIntensity, _this.dailyIntensity) || other.dailyIntensity == _this.dailyIntensity)&&(identical(other.maxDailyMinutes, _this.maxDailyMinutes) || other.maxDailyMinutes == _this.maxDailyMinutes)&&(identical(other.maxSessionMinutes, _this.maxSessionMinutes) || other.maxSessionMinutes == _this.maxSessionMinutes)&&(identical(other.planningBufferPercent, _this.planningBufferPercent) || other.planningBufferPercent == _this.planningBufferPercent)&&(identical(other.revisionBufferDays, _this.revisionBufferDays) || other.revisionBufferDays == _this.revisionBufferDays)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.archivedAt, _this.archivedAt) || other.archivedAt == _this.archivedAt));
}


@override
int get hashCode {
  final _this = this as StudyPlan;
  return Object.hash(runtimeType,_this.id,_this.name,_this.description,_this.planType,_this.status,_this.startDate,_this.targetEndDate,_this.primaryExamId,_this.planningMode,_this.dailyIntensity,_this.maxDailyMinutes,_this.maxSessionMinutes,_this.planningBufferPercent,_this.revisionBufferDays,_this.createdAt,_this.updatedAt,_this.archivedAt);
}

@override
String toString() {
  final _this = this as StudyPlan;
  return 'StudyPlan(id: ${_this.id}, name: ${_this.name}, description: ${_this.description}, planType: ${_this.planType}, status: ${_this.status}, startDate: ${_this.startDate}, targetEndDate: ${_this.targetEndDate}, primaryExamId: ${_this.primaryExamId}, planningMode: ${_this.planningMode}, dailyIntensity: ${_this.dailyIntensity}, maxDailyMinutes: ${_this.maxDailyMinutes}, maxSessionMinutes: ${_this.maxSessionMinutes}, planningBufferPercent: ${_this.planningBufferPercent}, revisionBufferDays: ${_this.revisionBufferDays}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, archivedAt: ${_this.archivedAt})';
}


}

/// @nodoc
abstract mixin class $StudyPlanCopyWith<$Res>  {
  factory $StudyPlanCopyWith(StudyPlan value, $Res Function(StudyPlan) _then) = _$StudyPlanCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, PlanType planType, StudyPlanStatus status, DateTime startDate, DateTime? targetEndDate, String? primaryExamId, PlanningMode planningMode, DailyIntensity dailyIntensity, int maxDailyMinutes, int maxSessionMinutes, int planningBufferPercent, int revisionBufferDays, DateTime createdAt, DateTime updatedAt, DateTime? archivedAt
});




}
/// @nodoc
class _$StudyPlanCopyWithImpl<$Res>
    implements $StudyPlanCopyWith<$Res> {
  _$StudyPlanCopyWithImpl(this._self, this._then);

  final StudyPlan _self;
  final $Res Function(StudyPlan) _then;

/// Create a copy of StudyPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? planType = null,Object? status = null,Object? startDate = null,Object? targetEndDate = freezed,Object? primaryExamId = freezed,Object? planningMode = null,Object? dailyIntensity = null,Object? maxDailyMinutes = null,Object? maxSessionMinutes = null,Object? planningBufferPercent = null,Object? revisionBufferDays = null,Object? createdAt = null,Object? updatedAt = null,Object? archivedAt = freezed,}) {
  return _then(StudyPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,planType: null == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
as PlanType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudyPlanStatus,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,targetEndDate: freezed == targetEndDate ? _self.targetEndDate : targetEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,primaryExamId: freezed == primaryExamId ? _self.primaryExamId : primaryExamId // ignore: cast_nullable_to_non_nullable
as String?,planningMode: null == planningMode ? _self.planningMode : planningMode // ignore: cast_nullable_to_non_nullable
as PlanningMode,dailyIntensity: null == dailyIntensity ? _self.dailyIntensity : dailyIntensity // ignore: cast_nullable_to_non_nullable
as DailyIntensity,maxDailyMinutes: null == maxDailyMinutes ? _self.maxDailyMinutes : maxDailyMinutes // ignore: cast_nullable_to_non_nullable
as int,maxSessionMinutes: null == maxSessionMinutes ? _self.maxSessionMinutes : maxSessionMinutes // ignore: cast_nullable_to_non_nullable
as int,planningBufferPercent: null == planningBufferPercent ? _self.planningBufferPercent : planningBufferPercent // ignore: cast_nullable_to_non_nullable
as int,revisionBufferDays: null == revisionBufferDays ? _self.revisionBufferDays : revisionBufferDays // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyPlan].
extension StudyPlanPatterns on StudyPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyPlan value)  $default,){
final _that = this;
switch (_that) {
case _StudyPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyPlan value)?  $default,){
final _that = this;
switch (_that) {
case _StudyPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  PlanType planType,  StudyPlanStatus status,  DateTime startDate,  DateTime? targetEndDate,  String? primaryExamId,  PlanningMode planningMode,  DailyIntensity dailyIntensity,  int maxDailyMinutes,  int maxSessionMinutes,  int planningBufferPercent,  int revisionBufferDays,  DateTime createdAt,  DateTime updatedAt,  DateTime? archivedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyPlan() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.planType,_that.status,_that.startDate,_that.targetEndDate,_that.primaryExamId,_that.planningMode,_that.dailyIntensity,_that.maxDailyMinutes,_that.maxSessionMinutes,_that.planningBufferPercent,_that.revisionBufferDays,_that.createdAt,_that.updatedAt,_that.archivedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  PlanType planType,  StudyPlanStatus status,  DateTime startDate,  DateTime? targetEndDate,  String? primaryExamId,  PlanningMode planningMode,  DailyIntensity dailyIntensity,  int maxDailyMinutes,  int maxSessionMinutes,  int planningBufferPercent,  int revisionBufferDays,  DateTime createdAt,  DateTime updatedAt,  DateTime? archivedAt)  $default,) {final _that = this;
switch (_that) {
case _StudyPlan():
return $default(_that.id,_that.name,_that.description,_that.planType,_that.status,_that.startDate,_that.targetEndDate,_that.primaryExamId,_that.planningMode,_that.dailyIntensity,_that.maxDailyMinutes,_that.maxSessionMinutes,_that.planningBufferPercent,_that.revisionBufferDays,_that.createdAt,_that.updatedAt,_that.archivedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  PlanType planType,  StudyPlanStatus status,  DateTime startDate,  DateTime? targetEndDate,  String? primaryExamId,  PlanningMode planningMode,  DailyIntensity dailyIntensity,  int maxDailyMinutes,  int maxSessionMinutes,  int planningBufferPercent,  int revisionBufferDays,  DateTime createdAt,  DateTime updatedAt,  DateTime? archivedAt)?  $default,) {final _that = this;
switch (_that) {
case _StudyPlan() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.planType,_that.status,_that.startDate,_that.targetEndDate,_that.primaryExamId,_that.planningMode,_that.dailyIntensity,_that.maxDailyMinutes,_that.maxSessionMinutes,_that.planningBufferPercent,_that.revisionBufferDays,_that.createdAt,_that.updatedAt,_that.archivedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StudyPlan implements StudyPlan {
  const _StudyPlan({required this.id, required this.name, this.description, required this.planType, required this.status, required this.startDate, this.targetEndDate, this.primaryExamId, required this.planningMode, required this.dailyIntensity, required this.maxDailyMinutes, required this.maxSessionMinutes, required this.planningBufferPercent, required this.revisionBufferDays, required this.createdAt, required this.updatedAt, this.archivedAt});
  

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  PlanType planType;
@override final  StudyPlanStatus status;
@override final  DateTime startDate;
@override final  DateTime? targetEndDate;
@override final  String? primaryExamId;
@override final  PlanningMode planningMode;
@override final  DailyIntensity dailyIntensity;
@override final  int maxDailyMinutes;
@override final  int maxSessionMinutes;
@override final  int planningBufferPercent;
@override final  int revisionBufferDays;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? archivedAt;

/// Create a copy of StudyPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyPlanCopyWith<_StudyPlan> get copyWith => __$StudyPlanCopyWithImpl<_StudyPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyPlan&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.planType, planType) || other.planType == planType)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.targetEndDate, targetEndDate) || other.targetEndDate == targetEndDate)&&(identical(other.primaryExamId, primaryExamId) || other.primaryExamId == primaryExamId)&&(identical(other.planningMode, planningMode) || other.planningMode == planningMode)&&(identical(other.dailyIntensity, dailyIntensity) || other.dailyIntensity == dailyIntensity)&&(identical(other.maxDailyMinutes, maxDailyMinutes) || other.maxDailyMinutes == maxDailyMinutes)&&(identical(other.maxSessionMinutes, maxSessionMinutes) || other.maxSessionMinutes == maxSessionMinutes)&&(identical(other.planningBufferPercent, planningBufferPercent) || other.planningBufferPercent == planningBufferPercent)&&(identical(other.revisionBufferDays, revisionBufferDays) || other.revisionBufferDays == revisionBufferDays)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.archivedAt, archivedAt) || other.archivedAt == archivedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,description,planType,status,startDate,targetEndDate,primaryExamId,planningMode,dailyIntensity,maxDailyMinutes,maxSessionMinutes,planningBufferPercent,revisionBufferDays,createdAt,updatedAt,archivedAt);
}

@override
String toString() {
    return 'StudyPlan(id: $id, name: $name, description: $description, planType: $planType, status: $status, startDate: $startDate, targetEndDate: $targetEndDate, primaryExamId: $primaryExamId, planningMode: $planningMode, dailyIntensity: $dailyIntensity, maxDailyMinutes: $maxDailyMinutes, maxSessionMinutes: $maxSessionMinutes, planningBufferPercent: $planningBufferPercent, revisionBufferDays: $revisionBufferDays, createdAt: $createdAt, updatedAt: $updatedAt, archivedAt: $archivedAt)';
}


}

/// @nodoc
abstract mixin class _$StudyPlanCopyWith<$Res> implements $StudyPlanCopyWith<$Res> {
  factory _$StudyPlanCopyWith(_StudyPlan value, $Res Function(_StudyPlan) _then) = __$StudyPlanCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, PlanType planType, StudyPlanStatus status, DateTime startDate, DateTime? targetEndDate, String? primaryExamId, PlanningMode planningMode, DailyIntensity dailyIntensity, int maxDailyMinutes, int maxSessionMinutes, int planningBufferPercent, int revisionBufferDays, DateTime createdAt, DateTime updatedAt, DateTime? archivedAt
});




}
/// @nodoc
class __$StudyPlanCopyWithImpl<$Res>
    implements _$StudyPlanCopyWith<$Res> {
  __$StudyPlanCopyWithImpl(this._self, this._then);

  final _StudyPlan _self;
  final $Res Function(_StudyPlan) _then;

/// Create a copy of StudyPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? planType = null,Object? status = null,Object? startDate = null,Object? targetEndDate = freezed,Object? primaryExamId = freezed,Object? planningMode = null,Object? dailyIntensity = null,Object? maxDailyMinutes = null,Object? maxSessionMinutes = null,Object? planningBufferPercent = null,Object? revisionBufferDays = null,Object? createdAt = null,Object? updatedAt = null,Object? archivedAt = freezed,}) {
  return _then(_StudyPlan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,planType: null == planType ? _self.planType : planType // ignore: cast_nullable_to_non_nullable
as PlanType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StudyPlanStatus,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,targetEndDate: freezed == targetEndDate ? _self.targetEndDate : targetEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,primaryExamId: freezed == primaryExamId ? _self.primaryExamId : primaryExamId // ignore: cast_nullable_to_non_nullable
as String?,planningMode: null == planningMode ? _self.planningMode : planningMode // ignore: cast_nullable_to_non_nullable
as PlanningMode,dailyIntensity: null == dailyIntensity ? _self.dailyIntensity : dailyIntensity // ignore: cast_nullable_to_non_nullable
as DailyIntensity,maxDailyMinutes: null == maxDailyMinutes ? _self.maxDailyMinutes : maxDailyMinutes // ignore: cast_nullable_to_non_nullable
as int,maxSessionMinutes: null == maxSessionMinutes ? _self.maxSessionMinutes : maxSessionMinutes // ignore: cast_nullable_to_non_nullable
as int,planningBufferPercent: null == planningBufferPercent ? _self.planningBufferPercent : planningBufferPercent // ignore: cast_nullable_to_non_nullable
as int,revisionBufferDays: null == revisionBufferDays ? _self.revisionBufferDays : revisionBufferDays // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
