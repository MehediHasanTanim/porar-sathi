// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'planner_run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlannerRun {

 String get id; String get studyPlanId; PlannerTrigger get trigger; DateTime get startedAt; DateTime? get completedAt; int get inputTaskCount; int get outputTaskCount; PlannerRiskLevel get riskLevel; DateTime? get expectedFinishDate; String get algorithmVersion;
/// Create a copy of PlannerRun
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlannerRunCopyWith<PlannerRun> get copyWith => _$PlannerRunCopyWithImpl<PlannerRun>(this as PlannerRun, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlannerRun;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlannerRun&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.trigger, _this.trigger) || other.trigger == _this.trigger)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.inputTaskCount, _this.inputTaskCount) || other.inputTaskCount == _this.inputTaskCount)&&(identical(other.outputTaskCount, _this.outputTaskCount) || other.outputTaskCount == _this.outputTaskCount)&&(identical(other.riskLevel, _this.riskLevel) || other.riskLevel == _this.riskLevel)&&(identical(other.expectedFinishDate, _this.expectedFinishDate) || other.expectedFinishDate == _this.expectedFinishDate)&&(identical(other.algorithmVersion, _this.algorithmVersion) || other.algorithmVersion == _this.algorithmVersion));
}


@override
int get hashCode {
  final _this = this as PlannerRun;
  return Object.hash(runtimeType,_this.id,_this.studyPlanId,_this.trigger,_this.startedAt,_this.completedAt,_this.inputTaskCount,_this.outputTaskCount,_this.riskLevel,_this.expectedFinishDate,_this.algorithmVersion);
}

@override
String toString() {
  final _this = this as PlannerRun;
  return 'PlannerRun(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, trigger: ${_this.trigger}, startedAt: ${_this.startedAt}, completedAt: ${_this.completedAt}, inputTaskCount: ${_this.inputTaskCount}, outputTaskCount: ${_this.outputTaskCount}, riskLevel: ${_this.riskLevel}, expectedFinishDate: ${_this.expectedFinishDate}, algorithmVersion: ${_this.algorithmVersion})';
}


}

/// @nodoc
abstract mixin class $PlannerRunCopyWith<$Res>  {
  factory $PlannerRunCopyWith(PlannerRun value, $Res Function(PlannerRun) _then) = _$PlannerRunCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, PlannerTrigger trigger, DateTime startedAt, DateTime? completedAt, int inputTaskCount, int outputTaskCount, PlannerRiskLevel riskLevel, DateTime? expectedFinishDate, String algorithmVersion
});




}
/// @nodoc
class _$PlannerRunCopyWithImpl<$Res>
    implements $PlannerRunCopyWith<$Res> {
  _$PlannerRunCopyWithImpl(this._self, this._then);

  final PlannerRun _self;
  final $Res Function(PlannerRun) _then;

/// Create a copy of PlannerRun
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? trigger = null,Object? startedAt = null,Object? completedAt = freezed,Object? inputTaskCount = null,Object? outputTaskCount = null,Object? riskLevel = null,Object? expectedFinishDate = freezed,Object? algorithmVersion = null,}) {
  return _then(PlannerRun(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as PlannerTrigger,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,inputTaskCount: null == inputTaskCount ? _self.inputTaskCount : inputTaskCount // ignore: cast_nullable_to_non_nullable
as int,outputTaskCount: null == outputTaskCount ? _self.outputTaskCount : outputTaskCount // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as PlannerRiskLevel,expectedFinishDate: freezed == expectedFinishDate ? _self.expectedFinishDate : expectedFinishDate // ignore: cast_nullable_to_non_nullable
as DateTime?,algorithmVersion: null == algorithmVersion ? _self.algorithmVersion : algorithmVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PlannerRun].
extension PlannerRunPatterns on PlannerRun {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlannerRun value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlannerRun() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlannerRun value)  $default,){
final _that = this;
switch (_that) {
case _PlannerRun():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlannerRun value)?  $default,){
final _that = this;
switch (_that) {
case _PlannerRun() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  PlannerTrigger trigger,  DateTime startedAt,  DateTime? completedAt,  int inputTaskCount,  int outputTaskCount,  PlannerRiskLevel riskLevel,  DateTime? expectedFinishDate,  String algorithmVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlannerRun() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.trigger,_that.startedAt,_that.completedAt,_that.inputTaskCount,_that.outputTaskCount,_that.riskLevel,_that.expectedFinishDate,_that.algorithmVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  PlannerTrigger trigger,  DateTime startedAt,  DateTime? completedAt,  int inputTaskCount,  int outputTaskCount,  PlannerRiskLevel riskLevel,  DateTime? expectedFinishDate,  String algorithmVersion)  $default,) {final _that = this;
switch (_that) {
case _PlannerRun():
return $default(_that.id,_that.studyPlanId,_that.trigger,_that.startedAt,_that.completedAt,_that.inputTaskCount,_that.outputTaskCount,_that.riskLevel,_that.expectedFinishDate,_that.algorithmVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  PlannerTrigger trigger,  DateTime startedAt,  DateTime? completedAt,  int inputTaskCount,  int outputTaskCount,  PlannerRiskLevel riskLevel,  DateTime? expectedFinishDate,  String algorithmVersion)?  $default,) {final _that = this;
switch (_that) {
case _PlannerRun() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.trigger,_that.startedAt,_that.completedAt,_that.inputTaskCount,_that.outputTaskCount,_that.riskLevel,_that.expectedFinishDate,_that.algorithmVersion);case _:
  return null;

}
}

}

/// @nodoc


class _PlannerRun implements PlannerRun {
  const _PlannerRun({required this.id, required this.studyPlanId, required this.trigger, required this.startedAt, this.completedAt, required this.inputTaskCount, required this.outputTaskCount, required this.riskLevel, this.expectedFinishDate, required this.algorithmVersion});
  

@override final  String id;
@override final  String studyPlanId;
@override final  PlannerTrigger trigger;
@override final  DateTime startedAt;
@override final  DateTime? completedAt;
@override final  int inputTaskCount;
@override final  int outputTaskCount;
@override final  PlannerRiskLevel riskLevel;
@override final  DateTime? expectedFinishDate;
@override final  String algorithmVersion;

/// Create a copy of PlannerRun
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlannerRunCopyWith<_PlannerRun> get copyWith => __$PlannerRunCopyWithImpl<_PlannerRun>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlannerRun&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.inputTaskCount, inputTaskCount) || other.inputTaskCount == inputTaskCount)&&(identical(other.outputTaskCount, outputTaskCount) || other.outputTaskCount == outputTaskCount)&&(identical(other.riskLevel, riskLevel) || other.riskLevel == riskLevel)&&(identical(other.expectedFinishDate, expectedFinishDate) || other.expectedFinishDate == expectedFinishDate)&&(identical(other.algorithmVersion, algorithmVersion) || other.algorithmVersion == algorithmVersion));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyPlanId,trigger,startedAt,completedAt,inputTaskCount,outputTaskCount,riskLevel,expectedFinishDate,algorithmVersion);
}

@override
String toString() {
    return 'PlannerRun(id: $id, studyPlanId: $studyPlanId, trigger: $trigger, startedAt: $startedAt, completedAt: $completedAt, inputTaskCount: $inputTaskCount, outputTaskCount: $outputTaskCount, riskLevel: $riskLevel, expectedFinishDate: $expectedFinishDate, algorithmVersion: $algorithmVersion)';
}


}

/// @nodoc
abstract mixin class _$PlannerRunCopyWith<$Res> implements $PlannerRunCopyWith<$Res> {
  factory _$PlannerRunCopyWith(_PlannerRun value, $Res Function(_PlannerRun) _then) = __$PlannerRunCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, PlannerTrigger trigger, DateTime startedAt, DateTime? completedAt, int inputTaskCount, int outputTaskCount, PlannerRiskLevel riskLevel, DateTime? expectedFinishDate, String algorithmVersion
});




}
/// @nodoc
class __$PlannerRunCopyWithImpl<$Res>
    implements _$PlannerRunCopyWith<$Res> {
  __$PlannerRunCopyWithImpl(this._self, this._then);

  final _PlannerRun _self;
  final $Res Function(_PlannerRun) _then;

/// Create a copy of PlannerRun
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? trigger = null,Object? startedAt = null,Object? completedAt = freezed,Object? inputTaskCount = null,Object? outputTaskCount = null,Object? riskLevel = null,Object? expectedFinishDate = freezed,Object? algorithmVersion = null,}) {
  return _then(_PlannerRun(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as PlannerTrigger,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,inputTaskCount: null == inputTaskCount ? _self.inputTaskCount : inputTaskCount // ignore: cast_nullable_to_non_nullable
as int,outputTaskCount: null == outputTaskCount ? _self.outputTaskCount : outputTaskCount // ignore: cast_nullable_to_non_nullable
as int,riskLevel: null == riskLevel ? _self.riskLevel : riskLevel // ignore: cast_nullable_to_non_nullable
as PlannerRiskLevel,expectedFinishDate: freezed == expectedFinishDate ? _self.expectedFinishDate : expectedFinishDate // ignore: cast_nullable_to_non_nullable
as DateTime?,algorithmVersion: null == algorithmVersion ? _self.algorithmVersion : algorithmVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
