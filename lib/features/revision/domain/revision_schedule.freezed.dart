// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revision_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RevisionSchedule {

 String get id; String get studyPlanId; String get chapterId; String? get topicId; String? get sourceStudySessionId; int get revisionNumber; DateTime get dueDate; int get estimatedMinutes; RevisionStatus get status; DateTime? get completedAt; DateTime get createdAt;
/// Create a copy of RevisionSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RevisionScheduleCopyWith<RevisionSchedule> get copyWith => _$RevisionScheduleCopyWithImpl<RevisionSchedule>(this as RevisionSchedule, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RevisionSchedule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RevisionSchedule&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.chapterId, _this.chapterId) || other.chapterId == _this.chapterId)&&(identical(other.topicId, _this.topicId) || other.topicId == _this.topicId)&&(identical(other.sourceStudySessionId, _this.sourceStudySessionId) || other.sourceStudySessionId == _this.sourceStudySessionId)&&(identical(other.revisionNumber, _this.revisionNumber) || other.revisionNumber == _this.revisionNumber)&&(identical(other.dueDate, _this.dueDate) || other.dueDate == _this.dueDate)&&(identical(other.estimatedMinutes, _this.estimatedMinutes) || other.estimatedMinutes == _this.estimatedMinutes)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as RevisionSchedule;
  return Object.hash(runtimeType,_this.id,_this.studyPlanId,_this.chapterId,_this.topicId,_this.sourceStudySessionId,_this.revisionNumber,_this.dueDate,_this.estimatedMinutes,_this.status,_this.completedAt,_this.createdAt);
}

@override
String toString() {
  final _this = this as RevisionSchedule;
  return 'RevisionSchedule(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, chapterId: ${_this.chapterId}, topicId: ${_this.topicId}, sourceStudySessionId: ${_this.sourceStudySessionId}, revisionNumber: ${_this.revisionNumber}, dueDate: ${_this.dueDate}, estimatedMinutes: ${_this.estimatedMinutes}, status: ${_this.status}, completedAt: ${_this.completedAt}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $RevisionScheduleCopyWith<$Res>  {
  factory $RevisionScheduleCopyWith(RevisionSchedule value, $Res Function(RevisionSchedule) _then) = _$RevisionScheduleCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, String chapterId, String? topicId, String? sourceStudySessionId, int revisionNumber, DateTime dueDate, int estimatedMinutes, RevisionStatus status, DateTime? completedAt, DateTime createdAt
});




}
/// @nodoc
class _$RevisionScheduleCopyWithImpl<$Res>
    implements $RevisionScheduleCopyWith<$Res> {
  _$RevisionScheduleCopyWithImpl(this._self, this._then);

  final RevisionSchedule _self;
  final $Res Function(RevisionSchedule) _then;

/// Create a copy of RevisionSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? chapterId = null,Object? topicId = freezed,Object? sourceStudySessionId = freezed,Object? revisionNumber = null,Object? dueDate = null,Object? estimatedMinutes = null,Object? status = null,Object? completedAt = freezed,Object? createdAt = null,}) {
  return _then(RevisionSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,sourceStudySessionId: freezed == sourceStudySessionId ? _self.sourceStudySessionId : sourceStudySessionId // ignore: cast_nullable_to_non_nullable
as String?,revisionNumber: null == revisionNumber ? _self.revisionNumber : revisionNumber // ignore: cast_nullable_to_non_nullable
as int,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RevisionStatus,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RevisionSchedule].
extension RevisionSchedulePatterns on RevisionSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RevisionSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RevisionSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RevisionSchedule value)  $default,){
final _that = this;
switch (_that) {
case _RevisionSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RevisionSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _RevisionSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String chapterId,  String? topicId,  String? sourceStudySessionId,  int revisionNumber,  DateTime dueDate,  int estimatedMinutes,  RevisionStatus status,  DateTime? completedAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RevisionSchedule() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.chapterId,_that.topicId,_that.sourceStudySessionId,_that.revisionNumber,_that.dueDate,_that.estimatedMinutes,_that.status,_that.completedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String chapterId,  String? topicId,  String? sourceStudySessionId,  int revisionNumber,  DateTime dueDate,  int estimatedMinutes,  RevisionStatus status,  DateTime? completedAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _RevisionSchedule():
return $default(_that.id,_that.studyPlanId,_that.chapterId,_that.topicId,_that.sourceStudySessionId,_that.revisionNumber,_that.dueDate,_that.estimatedMinutes,_that.status,_that.completedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  String chapterId,  String? topicId,  String? sourceStudySessionId,  int revisionNumber,  DateTime dueDate,  int estimatedMinutes,  RevisionStatus status,  DateTime? completedAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RevisionSchedule() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.chapterId,_that.topicId,_that.sourceStudySessionId,_that.revisionNumber,_that.dueDate,_that.estimatedMinutes,_that.status,_that.completedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _RevisionSchedule implements RevisionSchedule {
  const _RevisionSchedule({required this.id, required this.studyPlanId, required this.chapterId, this.topicId, this.sourceStudySessionId, required this.revisionNumber, required this.dueDate, required this.estimatedMinutes, required this.status, this.completedAt, required this.createdAt});
  

@override final  String id;
@override final  String studyPlanId;
@override final  String chapterId;
@override final  String? topicId;
@override final  String? sourceStudySessionId;
@override final  int revisionNumber;
@override final  DateTime dueDate;
@override final  int estimatedMinutes;
@override final  RevisionStatus status;
@override final  DateTime? completedAt;
@override final  DateTime createdAt;

/// Create a copy of RevisionSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RevisionScheduleCopyWith<_RevisionSchedule> get copyWith => __$RevisionScheduleCopyWithImpl<_RevisionSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevisionSchedule&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.sourceStudySessionId, sourceStudySessionId) || other.sourceStudySessionId == sourceStudySessionId)&&(identical(other.revisionNumber, revisionNumber) || other.revisionNumber == revisionNumber)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.status, status) || other.status == status)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyPlanId,chapterId,topicId,sourceStudySessionId,revisionNumber,dueDate,estimatedMinutes,status,completedAt,createdAt);
}

@override
String toString() {
    return 'RevisionSchedule(id: $id, studyPlanId: $studyPlanId, chapterId: $chapterId, topicId: $topicId, sourceStudySessionId: $sourceStudySessionId, revisionNumber: $revisionNumber, dueDate: $dueDate, estimatedMinutes: $estimatedMinutes, status: $status, completedAt: $completedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RevisionScheduleCopyWith<$Res> implements $RevisionScheduleCopyWith<$Res> {
  factory _$RevisionScheduleCopyWith(_RevisionSchedule value, $Res Function(_RevisionSchedule) _then) = __$RevisionScheduleCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, String chapterId, String? topicId, String? sourceStudySessionId, int revisionNumber, DateTime dueDate, int estimatedMinutes, RevisionStatus status, DateTime? completedAt, DateTime createdAt
});




}
/// @nodoc
class __$RevisionScheduleCopyWithImpl<$Res>
    implements _$RevisionScheduleCopyWith<$Res> {
  __$RevisionScheduleCopyWithImpl(this._self, this._then);

  final _RevisionSchedule _self;
  final $Res Function(_RevisionSchedule) _then;

/// Create a copy of RevisionSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? chapterId = null,Object? topicId = freezed,Object? sourceStudySessionId = freezed,Object? revisionNumber = null,Object? dueDate = null,Object? estimatedMinutes = null,Object? status = null,Object? completedAt = freezed,Object? createdAt = null,}) {
  return _then(_RevisionSchedule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,chapterId: null == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,sourceStudySessionId: freezed == sourceStudySessionId ? _self.sourceStudySessionId : sourceStudySessionId // ignore: cast_nullable_to_non_nullable
as String?,revisionNumber: null == revisionNumber ? _self.revisionNumber : revisionNumber // ignore: cast_nullable_to_non_nullable
as int,dueDate: null == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RevisionStatus,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
