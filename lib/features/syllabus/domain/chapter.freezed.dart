// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Chapter {

 String get id; String get subjectId; String get title; int? get chapterNumber; int get estimatedMinutes; int get completedMinutes; Difficulty get difficulty; Confidence get confidence; Priority get priority; Priority get examImportance; ChapterStatus get status; String? get notes; int get sortOrder; DateTime get createdAt; DateTime get updatedAt; DateTime? get completedAt;
/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterCopyWith<Chapter> get copyWith => _$ChapterCopyWithImpl<Chapter>(this as Chapter, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Chapter;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chapter&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.chapterNumber, _this.chapterNumber) || other.chapterNumber == _this.chapterNumber)&&(identical(other.estimatedMinutes, _this.estimatedMinutes) || other.estimatedMinutes == _this.estimatedMinutes)&&(identical(other.completedMinutes, _this.completedMinutes) || other.completedMinutes == _this.completedMinutes)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.examImportance, _this.examImportance) || other.examImportance == _this.examImportance)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt));
}


@override
int get hashCode {
  final _this = this as Chapter;
  return Object.hash(runtimeType,_this.id,_this.subjectId,_this.title,_this.chapterNumber,_this.estimatedMinutes,_this.completedMinutes,_this.difficulty,_this.confidence,_this.priority,_this.examImportance,_this.status,_this.notes,_this.sortOrder,_this.createdAt,_this.updatedAt,_this.completedAt);
}

@override
String toString() {
  final _this = this as Chapter;
  return 'Chapter(id: ${_this.id}, subjectId: ${_this.subjectId}, title: ${_this.title}, chapterNumber: ${_this.chapterNumber}, estimatedMinutes: ${_this.estimatedMinutes}, completedMinutes: ${_this.completedMinutes}, difficulty: ${_this.difficulty}, confidence: ${_this.confidence}, priority: ${_this.priority}, examImportance: ${_this.examImportance}, status: ${_this.status}, notes: ${_this.notes}, sortOrder: ${_this.sortOrder}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, completedAt: ${_this.completedAt})';
}


}

/// @nodoc
abstract mixin class $ChapterCopyWith<$Res>  {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) _then) = _$ChapterCopyWithImpl;
@useResult
$Res call({
 String id, String subjectId, String title, int? chapterNumber, int estimatedMinutes, int completedMinutes, Difficulty difficulty, Confidence confidence, Priority priority, Priority examImportance, ChapterStatus status, String? notes, int sortOrder, DateTime createdAt, DateTime updatedAt, DateTime? completedAt
});




}
/// @nodoc
class _$ChapterCopyWithImpl<$Res>
    implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._self, this._then);

  final Chapter _self;
  final $Res Function(Chapter) _then;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? subjectId = null,Object? title = null,Object? chapterNumber = freezed,Object? estimatedMinutes = null,Object? completedMinutes = null,Object? difficulty = null,Object? confidence = null,Object? priority = null,Object? examImportance = null,Object? status = null,Object? notes = freezed,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,}) {
  return _then(Chapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: freezed == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as int?,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,completedMinutes: null == completedMinutes ? _self.completedMinutes : completedMinutes // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as Confidence,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,examImportance: null == examImportance ? _self.examImportance : examImportance // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Chapter].
extension ChapterPatterns on Chapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chapter value)  $default,){
final _that = this;
switch (_that) {
case _Chapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chapter value)?  $default,){
final _that = this;
switch (_that) {
case _Chapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String subjectId,  String title,  int? chapterNumber,  int estimatedMinutes,  int completedMinutes,  Difficulty difficulty,  Confidence confidence,  Priority priority,  Priority examImportance,  ChapterStatus status,  String? notes,  int sortOrder,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chapter() when $default != null:
return $default(_that.id,_that.subjectId,_that.title,_that.chapterNumber,_that.estimatedMinutes,_that.completedMinutes,_that.difficulty,_that.confidence,_that.priority,_that.examImportance,_that.status,_that.notes,_that.sortOrder,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String subjectId,  String title,  int? chapterNumber,  int estimatedMinutes,  int completedMinutes,  Difficulty difficulty,  Confidence confidence,  Priority priority,  Priority examImportance,  ChapterStatus status,  String? notes,  int sortOrder,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _Chapter():
return $default(_that.id,_that.subjectId,_that.title,_that.chapterNumber,_that.estimatedMinutes,_that.completedMinutes,_that.difficulty,_that.confidence,_that.priority,_that.examImportance,_that.status,_that.notes,_that.sortOrder,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String subjectId,  String title,  int? chapterNumber,  int estimatedMinutes,  int completedMinutes,  Difficulty difficulty,  Confidence confidence,  Priority priority,  Priority examImportance,  ChapterStatus status,  String? notes,  int sortOrder,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _Chapter() when $default != null:
return $default(_that.id,_that.subjectId,_that.title,_that.chapterNumber,_that.estimatedMinutes,_that.completedMinutes,_that.difficulty,_that.confidence,_that.priority,_that.examImportance,_that.status,_that.notes,_that.sortOrder,_that.createdAt,_that.updatedAt,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Chapter implements Chapter {
  const _Chapter({required this.id, required this.subjectId, required this.title, this.chapterNumber, required this.estimatedMinutes, required this.completedMinutes, required this.difficulty, required this.confidence, required this.priority, required this.examImportance, required this.status, this.notes, required this.sortOrder, required this.createdAt, required this.updatedAt, this.completedAt});
  

@override final  String id;
@override final  String subjectId;
@override final  String title;
@override final  int? chapterNumber;
@override final  int estimatedMinutes;
@override final  int completedMinutes;
@override final  Difficulty difficulty;
@override final  Confidence confidence;
@override final  Priority priority;
@override final  Priority examImportance;
@override final  ChapterStatus status;
@override final  String? notes;
@override final  int sortOrder;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? completedAt;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterCopyWith<_Chapter> get copyWith => __$ChapterCopyWithImpl<_Chapter>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chapter&&(identical(other.id, id) || other.id == id)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.title, title) || other.title == title)&&(identical(other.chapterNumber, chapterNumber) || other.chapterNumber == chapterNumber)&&(identical(other.estimatedMinutes, estimatedMinutes) || other.estimatedMinutes == estimatedMinutes)&&(identical(other.completedMinutes, completedMinutes) || other.completedMinutes == completedMinutes)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.examImportance, examImportance) || other.examImportance == examImportance)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,subjectId,title,chapterNumber,estimatedMinutes,completedMinutes,difficulty,confidence,priority,examImportance,status,notes,sortOrder,createdAt,updatedAt,completedAt);
}

@override
String toString() {
    return 'Chapter(id: $id, subjectId: $subjectId, title: $title, chapterNumber: $chapterNumber, estimatedMinutes: $estimatedMinutes, completedMinutes: $completedMinutes, difficulty: $difficulty, confidence: $confidence, priority: $priority, examImportance: $examImportance, status: $status, notes: $notes, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$ChapterCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$ChapterCopyWith(_Chapter value, $Res Function(_Chapter) _then) = __$ChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, String subjectId, String title, int? chapterNumber, int estimatedMinutes, int completedMinutes, Difficulty difficulty, Confidence confidence, Priority priority, Priority examImportance, ChapterStatus status, String? notes, int sortOrder, DateTime createdAt, DateTime updatedAt, DateTime? completedAt
});




}
/// @nodoc
class __$ChapterCopyWithImpl<$Res>
    implements _$ChapterCopyWith<$Res> {
  __$ChapterCopyWithImpl(this._self, this._then);

  final _Chapter _self;
  final $Res Function(_Chapter) _then;

/// Create a copy of Chapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? subjectId = null,Object? title = null,Object? chapterNumber = freezed,Object? estimatedMinutes = null,Object? completedMinutes = null,Object? difficulty = null,Object? confidence = null,Object? priority = null,Object? examImportance = null,Object? status = null,Object? notes = freezed,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,}) {
  return _then(_Chapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,chapterNumber: freezed == chapterNumber ? _self.chapterNumber : chapterNumber // ignore: cast_nullable_to_non_nullable
as int?,estimatedMinutes: null == estimatedMinutes ? _self.estimatedMinutes : estimatedMinutes // ignore: cast_nullable_to_non_nullable
as int,completedMinutes: null == completedMinutes ? _self.completedMinutes : completedMinutes // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as Confidence,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,examImportance: null == examImportance ? _self.examImportance : examImportance // ignore: cast_nullable_to_non_nullable
as Priority,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChapterStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
