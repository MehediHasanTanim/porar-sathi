// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyTask {

 String get id; String get studyPlanId; String get subjectId; String? get chapterId; String? get topicId; String? get examId; TaskType get taskType; String get title; DateTime get plannedDate; int? get plannedStartTime; int get plannedMinutes; int? get actualMinutes; int get priorityScore; bool get isLocked; TaskStatus get status; int get completionPercent; TaskSource get source; String? get generationBatchId; DateTime get createdAt; DateTime get updatedAt; DateTime? get completedAt;
/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyTaskCopyWith<StudyTask> get copyWith => _$StudyTaskCopyWithImpl<StudyTask>(this as StudyTask, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudyTask;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyTask&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.chapterId, _this.chapterId) || other.chapterId == _this.chapterId)&&(identical(other.topicId, _this.topicId) || other.topicId == _this.topicId)&&(identical(other.examId, _this.examId) || other.examId == _this.examId)&&(identical(other.taskType, _this.taskType) || other.taskType == _this.taskType)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.plannedDate, _this.plannedDate) || other.plannedDate == _this.plannedDate)&&(identical(other.plannedStartTime, _this.plannedStartTime) || other.plannedStartTime == _this.plannedStartTime)&&(identical(other.plannedMinutes, _this.plannedMinutes) || other.plannedMinutes == _this.plannedMinutes)&&(identical(other.actualMinutes, _this.actualMinutes) || other.actualMinutes == _this.actualMinutes)&&(identical(other.priorityScore, _this.priorityScore) || other.priorityScore == _this.priorityScore)&&(identical(other.isLocked, _this.isLocked) || other.isLocked == _this.isLocked)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.completionPercent, _this.completionPercent) || other.completionPercent == _this.completionPercent)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.generationBatchId, _this.generationBatchId) || other.generationBatchId == _this.generationBatchId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}


@override
int get hashCode {
  final _this = this as StudyTask;
  return Object.hashAll([runtimeType,_this.id,_this.studyPlanId,_this.subjectId,_this.chapterId,_this.topicId,_this.examId,_this.taskType,_this.title,_this.plannedDate,_this.plannedStartTime,_this.plannedMinutes,_this.actualMinutes,_this.priorityScore,_this.isLocked,_this.status,_this.completionPercent,_this.source,_this.generationBatchId,_this.createdAt,_this.updatedAt,_this.completedAt]);
}

@override
String toString() {
  final _this = this as StudyTask;
  return 'StudyTask(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, subjectId: ${_this.subjectId}, chapterId: ${_this.chapterId}, topicId: ${_this.topicId}, examId: ${_this.examId}, taskType: ${_this.taskType}, title: ${_this.title}, plannedDate: ${_this.plannedDate}, plannedStartTime: ${_this.plannedStartTime}, plannedMinutes: ${_this.plannedMinutes}, actualMinutes: ${_this.actualMinutes}, priorityScore: ${_this.priorityScore}, isLocked: ${_this.isLocked}, status: ${_this.status}, completionPercent: ${_this.completionPercent}, source: ${_this.source}, generationBatchId: ${_this.generationBatchId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $StudyTaskCopyWith<$Res>  {
  factory $StudyTaskCopyWith(StudyTask value, $Res Function(StudyTask) _then) = _$StudyTaskCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, String subjectId, String? chapterId, String? topicId, String? examId, TaskType taskType, String title, DateTime plannedDate, int? plannedStartTime, int plannedMinutes, int? actualMinutes, int priorityScore, bool isLocked, TaskStatus status, int completionPercent, TaskSource source, String? generationBatchId, DateTime createdAt, DateTime updatedAt, DateTime? completedAt
});




}
/// @nodoc
class _$StudyTaskCopyWithImpl<$Res>
    implements $StudyTaskCopyWith<$Res> {
  _$StudyTaskCopyWithImpl(this._self, this._then);

  final StudyTask _self;
  final $Res Function(StudyTask) _then;

/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? subjectId = null,Object? chapterId = freezed,Object? topicId = freezed,Object? examId = freezed,Object? taskType = null,Object? title = null,Object? plannedDate = null,Object? plannedStartTime = freezed,Object? plannedMinutes = null,Object? actualMinutes = freezed,Object? priorityScore = null,Object? isLocked = null,Object? status = null,Object? completionPercent = null,Object? source = null,Object? generationBatchId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,}) {
  return _then(StudyTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,examId: freezed == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String?,taskType: null == taskType ? _self.taskType : taskType // ignore: cast_nullable_to_non_nullable
as TaskType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,plannedDate: null == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as DateTime,plannedStartTime: freezed == plannedStartTime ? _self.plannedStartTime : plannedStartTime // ignore: cast_nullable_to_non_nullable
as int?,plannedMinutes: null == plannedMinutes ? _self.plannedMinutes : plannedMinutes // ignore: cast_nullable_to_non_nullable
as int,actualMinutes: freezed == actualMinutes ? _self.actualMinutes : actualMinutes // ignore: cast_nullable_to_non_nullable
as int?,priorityScore: null == priorityScore ? _self.priorityScore : priorityScore // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TaskSource,generationBatchId: freezed == generationBatchId ? _self.generationBatchId : generationBatchId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyTask].
extension StudyTaskPatterns on StudyTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyTask value)  $default,){
final _that = this;
switch (_that) {
case _StudyTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyTask value)?  $default,){
final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String subjectId,  String? chapterId,  String? topicId,  String? examId,  TaskType taskType,  String title,  DateTime plannedDate,  int? plannedStartTime,  int plannedMinutes,  int? actualMinutes,  int priorityScore,  bool isLocked,  TaskStatus status,  int completionPercent,  TaskSource source,  String? generationBatchId,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.subjectId,_that.chapterId,_that.topicId,_that.examId,_that.taskType,_that.title,_that.plannedDate,_that.plannedStartTime,_that.plannedMinutes,_that.actualMinutes,_that.priorityScore,_that.isLocked,_that.status,_that.completionPercent,_that.source,_that.generationBatchId,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String subjectId,  String? chapterId,  String? topicId,  String? examId,  TaskType taskType,  String title,  DateTime plannedDate,  int? plannedStartTime,  int plannedMinutes,  int? actualMinutes,  int priorityScore,  bool isLocked,  TaskStatus status,  int completionPercent,  TaskSource source,  String? generationBatchId,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _StudyTask():
return $default(_that.id,_that.studyPlanId,_that.subjectId,_that.chapterId,_that.topicId,_that.examId,_that.taskType,_that.title,_that.plannedDate,_that.plannedStartTime,_that.plannedMinutes,_that.actualMinutes,_that.priorityScore,_that.isLocked,_that.status,_that.completionPercent,_that.source,_that.generationBatchId,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  String subjectId,  String? chapterId,  String? topicId,  String? examId,  TaskType taskType,  String title,  DateTime plannedDate,  int? plannedStartTime,  int plannedMinutes,  int? actualMinutes,  int priorityScore,  bool isLocked,  TaskStatus status,  int completionPercent,  TaskSource source,  String? generationBatchId,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _StudyTask() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.subjectId,_that.chapterId,_that.topicId,_that.examId,_that.taskType,_that.title,_that.plannedDate,_that.plannedStartTime,_that.plannedMinutes,_that.actualMinutes,_that.priorityScore,_that.isLocked,_that.status,_that.completionPercent,_that.source,_that.generationBatchId,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StudyTask implements StudyTask {
  const _StudyTask({required this.id, required this.studyPlanId, required this.subjectId, this.chapterId, this.topicId, this.examId, required this.taskType, required this.title, required this.plannedDate, this.plannedStartTime, required this.plannedMinutes, this.actualMinutes, required this.priorityScore, required this.isLocked, required this.status, required this.completionPercent, required this.source, this.generationBatchId, required this.createdAt, required this.updatedAt, this.completedAt});
  

@override final  String id;
@override final  String studyPlanId;
@override final  String subjectId;
@override final  String? chapterId;
@override final  String? topicId;
@override final  String? examId;
@override final  TaskType taskType;
@override final  String title;
@override final  DateTime plannedDate;
@override final  int? plannedStartTime;
@override final  int plannedMinutes;
@override final  int? actualMinutes;
@override final  int priorityScore;
@override final  bool isLocked;
@override final  TaskStatus status;
@override final  int completionPercent;
@override final  TaskSource source;
@override final  String? generationBatchId;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? completedAt;

/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyTaskCopyWith<_StudyTask> get copyWith => __$StudyTaskCopyWithImpl<_StudyTask>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyTask&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.examId, examId) || other.examId == examId)&&(identical(other.taskType, taskType) || other.taskType == taskType)&&(identical(other.title, title) || other.title == title)&&(identical(other.plannedDate, plannedDate) || other.plannedDate == plannedDate)&&(identical(other.plannedStartTime, plannedStartTime) || other.plannedStartTime == plannedStartTime)&&(identical(other.plannedMinutes, plannedMinutes) || other.plannedMinutes == plannedMinutes)&&(identical(other.actualMinutes, actualMinutes) || other.actualMinutes == actualMinutes)&&(identical(other.priorityScore, priorityScore) || other.priorityScore == priorityScore)&&(identical(other.isLocked, isLocked) || other.isLocked == isLocked)&&(identical(other.status, status) || other.status == status)&&(identical(other.completionPercent, completionPercent) || other.completionPercent == completionPercent)&&(identical(other.source, source) || other.source == source)&&(identical(other.generationBatchId, generationBatchId) || other.generationBatchId == generationBatchId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,id,studyPlanId,subjectId,chapterId,topicId,examId,taskType,title,plannedDate,plannedStartTime,plannedMinutes,actualMinutes,priorityScore,isLocked,status,completionPercent,source,generationBatchId,createdAt,updatedAt,completedAt]);
}

@override
String toString() {
    return 'StudyTask(id: $id, studyPlanId: $studyPlanId, subjectId: $subjectId, chapterId: $chapterId, topicId: $topicId, examId: $examId, taskType: $taskType, title: $title, plannedDate: $plannedDate, plannedStartTime: $plannedStartTime, plannedMinutes: $plannedMinutes, actualMinutes: $actualMinutes, priorityScore: $priorityScore, isLocked: $isLocked, status: $status, completionPercent: $completionPercent, source: $source, generationBatchId: $generationBatchId, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$StudyTaskCopyWith<$Res> implements $StudyTaskCopyWith<$Res> {
  factory _$StudyTaskCopyWith(_StudyTask value, $Res Function(_StudyTask) _then) = __$StudyTaskCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, String subjectId, String? chapterId, String? topicId, String? examId, TaskType taskType, String title, DateTime plannedDate, int? plannedStartTime, int plannedMinutes, int? actualMinutes, int priorityScore, bool isLocked, TaskStatus status, int completionPercent, TaskSource source, String? generationBatchId, DateTime createdAt, DateTime updatedAt, DateTime? completedAt
});




}
/// @nodoc
class __$StudyTaskCopyWithImpl<$Res>
    implements _$StudyTaskCopyWith<$Res> {
  __$StudyTaskCopyWithImpl(this._self, this._then);

  final _StudyTask _self;
  final $Res Function(_StudyTask) _then;

/// Create a copy of StudyTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? subjectId = null,Object? chapterId = freezed,Object? topicId = freezed,Object? examId = freezed,Object? taskType = null,Object? title = null,Object? plannedDate = null,Object? plannedStartTime = freezed,Object? plannedMinutes = null,Object? actualMinutes = freezed,Object? priorityScore = null,Object? isLocked = null,Object? status = null,Object? completionPercent = null,Object? source = null,Object? generationBatchId = freezed,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,}) {
  return _then(_StudyTask(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,examId: freezed == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String?,taskType: null == taskType ? _self.taskType : taskType // ignore: cast_nullable_to_non_nullable
as TaskType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,plannedDate: null == plannedDate ? _self.plannedDate : plannedDate // ignore: cast_nullable_to_non_nullable
as DateTime,plannedStartTime: freezed == plannedStartTime ? _self.plannedStartTime : plannedStartTime // ignore: cast_nullable_to_non_nullable
as int?,plannedMinutes: null == plannedMinutes ? _self.plannedMinutes : plannedMinutes // ignore: cast_nullable_to_non_nullable
as int,actualMinutes: freezed == actualMinutes ? _self.actualMinutes : actualMinutes // ignore: cast_nullable_to_non_nullable
as int?,priorityScore: null == priorityScore ? _self.priorityScore : priorityScore // ignore: cast_nullable_to_non_nullable
as int,isLocked: null == isLocked ? _self.isLocked : isLocked // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TaskStatus,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as TaskSource,generationBatchId: freezed == generationBatchId ? _self.generationBatchId : generationBatchId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
