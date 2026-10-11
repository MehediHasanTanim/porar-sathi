// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Exam {

 String get id; String get studyPlanId; String get name; ExamType get examType; DateTime get startDate; DateTime? get endDate; int? get timeOfDay; Priority get importance; String? get notes; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Exam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExamCopyWith<Exam> get copyWith => _$ExamCopyWithImpl<Exam>(this as Exam, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Exam;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Exam&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.examType, _this.examType) || other.examType == _this.examType)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.endDate, _this.endDate) || other.endDate == _this.endDate)&&(identical(other.timeOfDay, _this.timeOfDay) || other.timeOfDay == _this.timeOfDay)&&(identical(other.importance, _this.importance) || other.importance == _this.importance)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Exam;
  return Object.hash(runtimeType,_this.id,_this.studyPlanId,_this.name,_this.examType,_this.startDate,_this.endDate,_this.timeOfDay,_this.importance,_this.notes,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Exam;
  return 'Exam(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, name: ${_this.name}, examType: ${_this.examType}, startDate: ${_this.startDate}, endDate: ${_this.endDate}, timeOfDay: ${_this.timeOfDay}, importance: ${_this.importance}, notes: ${_this.notes}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $ExamCopyWith<$Res>  {
  factory $ExamCopyWith(Exam value, $Res Function(Exam) _then) = _$ExamCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, String name, ExamType examType, DateTime startDate, DateTime? endDate, int? timeOfDay, Priority importance, String? notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$ExamCopyWithImpl<$Res>
    implements $ExamCopyWith<$Res> {
  _$ExamCopyWithImpl(this._self, this._then);

  final Exam _self;
  final $Res Function(Exam) _then;

/// Create a copy of Exam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? name = null,Object? examType = null,Object? startDate = null,Object? endDate = freezed,Object? timeOfDay = freezed,Object? importance = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Exam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,examType: null == examType ? _self.examType : examType // ignore: cast_nullable_to_non_nullable
as ExamType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timeOfDay: freezed == timeOfDay ? _self.timeOfDay : timeOfDay // ignore: cast_nullable_to_non_nullable
as int?,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as Priority,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Exam].
extension ExamPatterns on Exam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Exam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Exam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Exam value)  $default,){
final _that = this;
switch (_that) {
case _Exam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Exam value)?  $default,){
final _that = this;
switch (_that) {
case _Exam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String name,  ExamType examType,  DateTime startDate,  DateTime? endDate,  int? timeOfDay,  Priority importance,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Exam() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.name,_that.examType,_that.startDate,_that.endDate,_that.timeOfDay,_that.importance,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String name,  ExamType examType,  DateTime startDate,  DateTime? endDate,  int? timeOfDay,  Priority importance,  String? notes,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Exam():
return $default(_that.id,_that.studyPlanId,_that.name,_that.examType,_that.startDate,_that.endDate,_that.timeOfDay,_that.importance,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  String name,  ExamType examType,  DateTime startDate,  DateTime? endDate,  int? timeOfDay,  Priority importance,  String? notes,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Exam() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.name,_that.examType,_that.startDate,_that.endDate,_that.timeOfDay,_that.importance,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Exam implements Exam {
  const _Exam({required this.id, required this.studyPlanId, required this.name, required this.examType, required this.startDate, this.endDate, this.timeOfDay, required this.importance, this.notes, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String studyPlanId;
@override final  String name;
@override final  ExamType examType;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  int? timeOfDay;
@override final  Priority importance;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Exam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExamCopyWith<_Exam> get copyWith => __$ExamCopyWithImpl<_Exam>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Exam&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.name, name) || other.name == name)&&(identical(other.examType, examType) || other.examType == examType)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.timeOfDay, timeOfDay) || other.timeOfDay == timeOfDay)&&(identical(other.importance, importance) || other.importance == importance)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyPlanId,name,examType,startDate,endDate,timeOfDay,importance,notes,createdAt,updatedAt);
}

@override
String toString() {
    return 'Exam(id: $id, studyPlanId: $studyPlanId, name: $name, examType: $examType, startDate: $startDate, endDate: $endDate, timeOfDay: $timeOfDay, importance: $importance, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ExamCopyWith<$Res> implements $ExamCopyWith<$Res> {
  factory _$ExamCopyWith(_Exam value, $Res Function(_Exam) _then) = __$ExamCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, String name, ExamType examType, DateTime startDate, DateTime? endDate, int? timeOfDay, Priority importance, String? notes, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$ExamCopyWithImpl<$Res>
    implements _$ExamCopyWith<$Res> {
  __$ExamCopyWithImpl(this._self, this._then);

  final _Exam _self;
  final $Res Function(_Exam) _then;

/// Create a copy of Exam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? name = null,Object? examType = null,Object? startDate = null,Object? endDate = freezed,Object? timeOfDay = freezed,Object? importance = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Exam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,examType: null == examType ? _self.examType : examType // ignore: cast_nullable_to_non_nullable
as ExamType,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,timeOfDay: freezed == timeOfDay ? _self.timeOfDay : timeOfDay // ignore: cast_nullable_to_non_nullable
as int?,importance: null == importance ? _self.importance : importance // ignore: cast_nullable_to_non_nullable
as Priority,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
