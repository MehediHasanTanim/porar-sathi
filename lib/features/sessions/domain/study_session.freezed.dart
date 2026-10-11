// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudySession {

 String get id; String? get studyTaskId; String get subjectId; String? get chapterId; String? get topicId; DateTime get startedAt; DateTime? get endedAt; int get plannedMinutes; int get actualMinutes; int get completionPercent; SessionResult get result; Confidence? get confidenceBefore; Confidence? get confidenceAfter; String? get note; DateTime get createdAt;
/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudySessionCopyWith<StudySession> get copyWith => _$StudySessionCopyWithImpl<StudySession>(this as StudySession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudySession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudySession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyTaskId, _this.studyTaskId) || other.studyTaskId == _this.studyTaskId)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.chapterId, _this.chapterId) || other.chapterId == _this.chapterId)&&(identical(other.topicId, _this.topicId) || other.topicId == _this.topicId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.plannedMinutes, _this.plannedMinutes) || other.plannedMinutes == _this.plannedMinutes)&&(identical(other.actualMinutes, _this.actualMinutes) || other.actualMinutes == _this.actualMinutes)&&(identical(other.completionPercent, _this.completionPercent) || other.completionPercent == _this.completionPercent)&&(identical(other.result, _this.result) || other.result == _this.result)&&(identical(other.confidenceBefore, _this.confidenceBefore) || other.confidenceBefore == _this.confidenceBefore)&&(identical(other.confidenceAfter, _this.confidenceAfter) || other.confidenceAfter == _this.confidenceAfter)&&(identical(other.note, _this.note) || other.note == _this.note)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as StudySession;
  return Object.hash(runtimeType,_this.id,_this.studyTaskId,_this.subjectId,_this.chapterId,_this.topicId,_this.startedAt,_this.endedAt,_this.plannedMinutes,_this.actualMinutes,_this.completionPercent,_this.result,_this.confidenceBefore,_this.confidenceAfter,_this.note,_this.createdAt);
}

@override
String toString() {
  final _this = this as StudySession;
  return 'StudySession(id: ${_this.id}, studyTaskId: ${_this.studyTaskId}, subjectId: ${_this.subjectId}, chapterId: ${_this.chapterId}, topicId: ${_this.topicId}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt}, plannedMinutes: ${_this.plannedMinutes}, actualMinutes: ${_this.actualMinutes}, completionPercent: ${_this.completionPercent}, result: ${_this.result}, confidenceBefore: ${_this.confidenceBefore}, confidenceAfter: ${_this.confidenceAfter}, note: ${_this.note}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $StudySessionCopyWith<$Res>  {
  factory $StudySessionCopyWith(StudySession value, $Res Function(StudySession) _then) = _$StudySessionCopyWithImpl;
@useResult
$Res call({
 String id, String? studyTaskId, String subjectId, String? chapterId, String? topicId, DateTime startedAt, DateTime? endedAt, int plannedMinutes, int actualMinutes, int completionPercent, SessionResult result, Confidence? confidenceBefore, Confidence? confidenceAfter, String? note, DateTime createdAt
});




}
/// @nodoc
class _$StudySessionCopyWithImpl<$Res>
    implements $StudySessionCopyWith<$Res> {
  _$StudySessionCopyWithImpl(this._self, this._then);

  final StudySession _self;
  final $Res Function(StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyTaskId = freezed,Object? subjectId = null,Object? chapterId = freezed,Object? topicId = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? plannedMinutes = null,Object? actualMinutes = null,Object? completionPercent = null,Object? result = null,Object? confidenceBefore = freezed,Object? confidenceAfter = freezed,Object? note = freezed,Object? createdAt = null,}) {
  return _then(StudySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyTaskId: freezed == studyTaskId ? _self.studyTaskId : studyTaskId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,plannedMinutes: null == plannedMinutes ? _self.plannedMinutes : plannedMinutes // ignore: cast_nullable_to_non_nullable
as int,actualMinutes: null == actualMinutes ? _self.actualMinutes : actualMinutes // ignore: cast_nullable_to_non_nullable
as int,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SessionResult,confidenceBefore: freezed == confidenceBefore ? _self.confidenceBefore : confidenceBefore // ignore: cast_nullable_to_non_nullable
as Confidence?,confidenceAfter: freezed == confidenceAfter ? _self.confidenceAfter : confidenceAfter // ignore: cast_nullable_to_non_nullable
as Confidence?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StudySession].
extension StudySessionPatterns on StudySession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudySession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudySession value)  $default,){
final _that = this;
switch (_that) {
case _StudySession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudySession value)?  $default,){
final _that = this;
switch (_that) {
case _StudySession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? studyTaskId,  String subjectId,  String? chapterId,  String? topicId,  DateTime startedAt,  DateTime? endedAt,  int plannedMinutes,  int actualMinutes,  int completionPercent,  SessionResult result,  Confidence? confidenceBefore,  Confidence? confidenceAfter,  String? note,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.studyTaskId,_that.subjectId,_that.chapterId,_that.topicId,_that.startedAt,_that.endedAt,_that.plannedMinutes,_that.actualMinutes,_that.completionPercent,_that.result,_that.confidenceBefore,_that.confidenceAfter,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? studyTaskId,  String subjectId,  String? chapterId,  String? topicId,  DateTime startedAt,  DateTime? endedAt,  int plannedMinutes,  int actualMinutes,  int completionPercent,  SessionResult result,  Confidence? confidenceBefore,  Confidence? confidenceAfter,  String? note,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _StudySession():
return $default(_that.id,_that.studyTaskId,_that.subjectId,_that.chapterId,_that.topicId,_that.startedAt,_that.endedAt,_that.plannedMinutes,_that.actualMinutes,_that.completionPercent,_that.result,_that.confidenceBefore,_that.confidenceAfter,_that.note,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? studyTaskId,  String subjectId,  String? chapterId,  String? topicId,  DateTime startedAt,  DateTime? endedAt,  int plannedMinutes,  int actualMinutes,  int completionPercent,  SessionResult result,  Confidence? confidenceBefore,  Confidence? confidenceAfter,  String? note,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _StudySession() when $default != null:
return $default(_that.id,_that.studyTaskId,_that.subjectId,_that.chapterId,_that.topicId,_that.startedAt,_that.endedAt,_that.plannedMinutes,_that.actualMinutes,_that.completionPercent,_that.result,_that.confidenceBefore,_that.confidenceAfter,_that.note,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _StudySession implements StudySession {
  const _StudySession({required this.id, this.studyTaskId, required this.subjectId, this.chapterId, this.topicId, required this.startedAt, this.endedAt, required this.plannedMinutes, required this.actualMinutes, required this.completionPercent, required this.result, this.confidenceBefore, this.confidenceAfter, this.note, required this.createdAt});
  

@override final  String id;
@override final  String? studyTaskId;
@override final  String subjectId;
@override final  String? chapterId;
@override final  String? topicId;
@override final  DateTime startedAt;
@override final  DateTime? endedAt;
@override final  int plannedMinutes;
@override final  int actualMinutes;
@override final  int completionPercent;
@override final  SessionResult result;
@override final  Confidence? confidenceBefore;
@override final  Confidence? confidenceAfter;
@override final  String? note;
@override final  DateTime createdAt;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudySessionCopyWith<_StudySession> get copyWith => __$StudySessionCopyWithImpl<_StudySession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudySession&&(identical(other.id, id) || other.id == id)&&(identical(other.studyTaskId, studyTaskId) || other.studyTaskId == studyTaskId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.plannedMinutes, plannedMinutes) || other.plannedMinutes == plannedMinutes)&&(identical(other.actualMinutes, actualMinutes) || other.actualMinutes == actualMinutes)&&(identical(other.completionPercent, completionPercent) || other.completionPercent == completionPercent)&&(identical(other.result, result) || other.result == result)&&(identical(other.confidenceBefore, confidenceBefore) || other.confidenceBefore == confidenceBefore)&&(identical(other.confidenceAfter, confidenceAfter) || other.confidenceAfter == confidenceAfter)&&(identical(other.note, note) || other.note == note)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyTaskId,subjectId,chapterId,topicId,startedAt,endedAt,plannedMinutes,actualMinutes,completionPercent,result,confidenceBefore,confidenceAfter,note,createdAt);
}

@override
String toString() {
    return 'StudySession(id: $id, studyTaskId: $studyTaskId, subjectId: $subjectId, chapterId: $chapterId, topicId: $topicId, startedAt: $startedAt, endedAt: $endedAt, plannedMinutes: $plannedMinutes, actualMinutes: $actualMinutes, completionPercent: $completionPercent, result: $result, confidenceBefore: $confidenceBefore, confidenceAfter: $confidenceAfter, note: $note, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$StudySessionCopyWith<$Res> implements $StudySessionCopyWith<$Res> {
  factory _$StudySessionCopyWith(_StudySession value, $Res Function(_StudySession) _then) = __$StudySessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String? studyTaskId, String subjectId, String? chapterId, String? topicId, DateTime startedAt, DateTime? endedAt, int plannedMinutes, int actualMinutes, int completionPercent, SessionResult result, Confidence? confidenceBefore, Confidence? confidenceAfter, String? note, DateTime createdAt
});




}
/// @nodoc
class __$StudySessionCopyWithImpl<$Res>
    implements _$StudySessionCopyWith<$Res> {
  __$StudySessionCopyWithImpl(this._self, this._then);

  final _StudySession _self;
  final $Res Function(_StudySession) _then;

/// Create a copy of StudySession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyTaskId = freezed,Object? subjectId = null,Object? chapterId = freezed,Object? topicId = freezed,Object? startedAt = null,Object? endedAt = freezed,Object? plannedMinutes = null,Object? actualMinutes = null,Object? completionPercent = null,Object? result = null,Object? confidenceBefore = freezed,Object? confidenceAfter = freezed,Object? note = freezed,Object? createdAt = null,}) {
  return _then(_StudySession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyTaskId: freezed == studyTaskId ? _self.studyTaskId : studyTaskId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,plannedMinutes: null == plannedMinutes ? _self.plannedMinutes : plannedMinutes // ignore: cast_nullable_to_non_nullable
as int,actualMinutes: null == actualMinutes ? _self.actualMinutes : actualMinutes // ignore: cast_nullable_to_non_nullable
as int,completionPercent: null == completionPercent ? _self.completionPercent : completionPercent // ignore: cast_nullable_to_non_nullable
as int,result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as SessionResult,confidenceBefore: freezed == confidenceBefore ? _self.confidenceBefore : confidenceBefore // ignore: cast_nullable_to_non_nullable
as Confidence?,confidenceAfter: freezed == confidenceAfter ? _self.confidenceAfter : confidenceAfter // ignore: cast_nullable_to_non_nullable
as Confidence?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
