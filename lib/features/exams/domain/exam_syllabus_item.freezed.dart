// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exam_syllabus_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExamSyllabusItem {

 String get id; String get examId; String get subjectId; String? get chapterId; String? get topicId; int get weight; bool get isRequired;
/// Create a copy of ExamSyllabusItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExamSyllabusItemCopyWith<ExamSyllabusItem> get copyWith => _$ExamSyllabusItemCopyWithImpl<ExamSyllabusItem>(this as ExamSyllabusItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ExamSyllabusItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExamSyllabusItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.examId, _this.examId) || other.examId == _this.examId)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId)&&(identical(other.chapterId, _this.chapterId) || other.chapterId == _this.chapterId)&&(identical(other.topicId, _this.topicId) || other.topicId == _this.topicId)&&(identical(other.weight, _this.weight) || other.weight == _this.weight)&&(identical(other.isRequired, _this.isRequired) || other.isRequired == _this.isRequired));
}


@override
int get hashCode {
  final _this = this as ExamSyllabusItem;
  return Object.hash(runtimeType,_this.id,_this.examId,_this.subjectId,_this.chapterId,_this.topicId,_this.weight,_this.isRequired);
}

@override
String toString() {
  final _this = this as ExamSyllabusItem;
  return 'ExamSyllabusItem(id: ${_this.id}, examId: ${_this.examId}, subjectId: ${_this.subjectId}, chapterId: ${_this.chapterId}, topicId: ${_this.topicId}, weight: ${_this.weight}, isRequired: ${_this.isRequired})';
}


}

/// @nodoc
abstract mixin class $ExamSyllabusItemCopyWith<$Res>  {
  factory $ExamSyllabusItemCopyWith(ExamSyllabusItem value, $Res Function(ExamSyllabusItem) _then) = _$ExamSyllabusItemCopyWithImpl;
@useResult
$Res call({
 String id, String examId, String subjectId, String? chapterId, String? topicId, int weight, bool isRequired
});




}
/// @nodoc
class _$ExamSyllabusItemCopyWithImpl<$Res>
    implements $ExamSyllabusItemCopyWith<$Res> {
  _$ExamSyllabusItemCopyWithImpl(this._self, this._then);

  final ExamSyllabusItem _self;
  final $Res Function(ExamSyllabusItem) _then;

/// Create a copy of ExamSyllabusItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? examId = null,Object? subjectId = null,Object? chapterId = freezed,Object? topicId = freezed,Object? weight = null,Object? isRequired = null,}) {
  return _then(ExamSyllabusItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,examId: null == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExamSyllabusItem].
extension ExamSyllabusItemPatterns on ExamSyllabusItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExamSyllabusItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExamSyllabusItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExamSyllabusItem value)  $default,){
final _that = this;
switch (_that) {
case _ExamSyllabusItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExamSyllabusItem value)?  $default,){
final _that = this;
switch (_that) {
case _ExamSyllabusItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String examId,  String subjectId,  String? chapterId,  String? topicId,  int weight,  bool isRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExamSyllabusItem() when $default != null:
return $default(_that.id,_that.examId,_that.subjectId,_that.chapterId,_that.topicId,_that.weight,_that.isRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String examId,  String subjectId,  String? chapterId,  String? topicId,  int weight,  bool isRequired)  $default,) {final _that = this;
switch (_that) {
case _ExamSyllabusItem():
return $default(_that.id,_that.examId,_that.subjectId,_that.chapterId,_that.topicId,_that.weight,_that.isRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String examId,  String subjectId,  String? chapterId,  String? topicId,  int weight,  bool isRequired)?  $default,) {final _that = this;
switch (_that) {
case _ExamSyllabusItem() when $default != null:
return $default(_that.id,_that.examId,_that.subjectId,_that.chapterId,_that.topicId,_that.weight,_that.isRequired);case _:
  return null;

}
}

}

/// @nodoc


class _ExamSyllabusItem implements ExamSyllabusItem {
  const _ExamSyllabusItem({required this.id, required this.examId, required this.subjectId, this.chapterId, this.topicId, required this.weight, required this.isRequired});
  

@override final  String id;
@override final  String examId;
@override final  String subjectId;
@override final  String? chapterId;
@override final  String? topicId;
@override final  int weight;
@override final  bool isRequired;

/// Create a copy of ExamSyllabusItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExamSyllabusItemCopyWith<_ExamSyllabusItem> get copyWith => __$ExamSyllabusItemCopyWithImpl<_ExamSyllabusItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExamSyllabusItem&&(identical(other.id, id) || other.id == id)&&(identical(other.examId, examId) || other.examId == examId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.chapterId, chapterId) || other.chapterId == chapterId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.isRequired, isRequired) || other.isRequired == isRequired));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,examId,subjectId,chapterId,topicId,weight,isRequired);
}

@override
String toString() {
    return 'ExamSyllabusItem(id: $id, examId: $examId, subjectId: $subjectId, chapterId: $chapterId, topicId: $topicId, weight: $weight, isRequired: $isRequired)';
}


}

/// @nodoc
abstract mixin class _$ExamSyllabusItemCopyWith<$Res> implements $ExamSyllabusItemCopyWith<$Res> {
  factory _$ExamSyllabusItemCopyWith(_ExamSyllabusItem value, $Res Function(_ExamSyllabusItem) _then) = __$ExamSyllabusItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String examId, String subjectId, String? chapterId, String? topicId, int weight, bool isRequired
});




}
/// @nodoc
class __$ExamSyllabusItemCopyWithImpl<$Res>
    implements _$ExamSyllabusItemCopyWith<$Res> {
  __$ExamSyllabusItemCopyWithImpl(this._self, this._then);

  final _ExamSyllabusItem _self;
  final $Res Function(_ExamSyllabusItem) _then;

/// Create a copy of ExamSyllabusItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? examId = null,Object? subjectId = null,Object? chapterId = freezed,Object? topicId = freezed,Object? weight = null,Object? isRequired = null,}) {
  return _then(_ExamSyllabusItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,examId: null == examId ? _self.examId : examId // ignore: cast_nullable_to_non_nullable
as String,subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String,chapterId: freezed == chapterId ? _self.chapterId : chapterId // ignore: cast_nullable_to_non_nullable
as String?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as String?,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,isRequired: null == isRequired ? _self.isRequired : isRequired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
