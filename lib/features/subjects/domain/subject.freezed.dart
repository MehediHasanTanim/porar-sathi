// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Subject {

 String get id; String get studyPlanId; String get name; String? get code; String? get paperName; String get colorToken; String get iconToken; Priority get priority; Difficulty get difficulty; Confidence get confidence; SubjectStatus get status; int get sortOrder; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectCopyWith<Subject> get copyWith => _$SubjectCopyWithImpl<Subject>(this as Subject, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Subject;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subject&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.studyPlanId, _this.studyPlanId) || other.studyPlanId == _this.studyPlanId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.paperName, _this.paperName) || other.paperName == _this.paperName)&&(identical(other.colorToken, _this.colorToken) || other.colorToken == _this.colorToken)&&(identical(other.iconToken, _this.iconToken) || other.iconToken == _this.iconToken)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.confidence, _this.confidence) || other.confidence == _this.confidence)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Subject;
  return Object.hash(runtimeType,_this.id,_this.studyPlanId,_this.name,_this.code,_this.paperName,_this.colorToken,_this.iconToken,_this.priority,_this.difficulty,_this.confidence,_this.status,_this.sortOrder,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Subject;
  return 'Subject(id: ${_this.id}, studyPlanId: ${_this.studyPlanId}, name: ${_this.name}, code: ${_this.code}, paperName: ${_this.paperName}, colorToken: ${_this.colorToken}, iconToken: ${_this.iconToken}, priority: ${_this.priority}, difficulty: ${_this.difficulty}, confidence: ${_this.confidence}, status: ${_this.status}, sortOrder: ${_this.sortOrder}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $SubjectCopyWith<$Res>  {
  factory $SubjectCopyWith(Subject value, $Res Function(Subject) _then) = _$SubjectCopyWithImpl;
@useResult
$Res call({
 String id, String studyPlanId, String name, String? code, String? paperName, String colorToken, String iconToken, Priority priority, Difficulty difficulty, Confidence confidence, SubjectStatus status, int sortOrder, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$SubjectCopyWithImpl<$Res>
    implements $SubjectCopyWith<$Res> {
  _$SubjectCopyWithImpl(this._self, this._then);

  final Subject _self;
  final $Res Function(Subject) _then;

/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? studyPlanId = null,Object? name = null,Object? code = freezed,Object? paperName = freezed,Object? colorToken = null,Object? iconToken = null,Object? priority = null,Object? difficulty = null,Object? confidence = null,Object? status = null,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(Subject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,paperName: freezed == paperName ? _self.paperName : paperName // ignore: cast_nullable_to_non_nullable
as String?,colorToken: null == colorToken ? _self.colorToken : colorToken // ignore: cast_nullable_to_non_nullable
as String,iconToken: null == iconToken ? _self.iconToken : iconToken // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as Confidence,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubjectStatus,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Subject].
extension SubjectPatterns on Subject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subject value)  $default,){
final _that = this;
switch (_that) {
case _Subject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subject value)?  $default,){
final _that = this;
switch (_that) {
case _Subject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String name,  String? code,  String? paperName,  String colorToken,  String iconToken,  Priority priority,  Difficulty difficulty,  Confidence confidence,  SubjectStatus status,  int sortOrder,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subject() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.name,_that.code,_that.paperName,_that.colorToken,_that.iconToken,_that.priority,_that.difficulty,_that.confidence,_that.status,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String studyPlanId,  String name,  String? code,  String? paperName,  String colorToken,  String iconToken,  Priority priority,  Difficulty difficulty,  Confidence confidence,  SubjectStatus status,  int sortOrder,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Subject():
return $default(_that.id,_that.studyPlanId,_that.name,_that.code,_that.paperName,_that.colorToken,_that.iconToken,_that.priority,_that.difficulty,_that.confidence,_that.status,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String studyPlanId,  String name,  String? code,  String? paperName,  String colorToken,  String iconToken,  Priority priority,  Difficulty difficulty,  Confidence confidence,  SubjectStatus status,  int sortOrder,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Subject() when $default != null:
return $default(_that.id,_that.studyPlanId,_that.name,_that.code,_that.paperName,_that.colorToken,_that.iconToken,_that.priority,_that.difficulty,_that.confidence,_that.status,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Subject implements Subject {
  const _Subject({required this.id, required this.studyPlanId, required this.name, this.code, this.paperName, required this.colorToken, required this.iconToken, required this.priority, required this.difficulty, required this.confidence, required this.status, required this.sortOrder, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String studyPlanId;
@override final  String name;
@override final  String? code;
@override final  String? paperName;
@override final  String colorToken;
@override final  String iconToken;
@override final  Priority priority;
@override final  Difficulty difficulty;
@override final  Confidence confidence;
@override final  SubjectStatus status;
@override final  int sortOrder;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectCopyWith<_Subject> get copyWith => __$SubjectCopyWithImpl<_Subject>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subject&&(identical(other.id, id) || other.id == id)&&(identical(other.studyPlanId, studyPlanId) || other.studyPlanId == studyPlanId)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.paperName, paperName) || other.paperName == paperName)&&(identical(other.colorToken, colorToken) || other.colorToken == colorToken)&&(identical(other.iconToken, iconToken) || other.iconToken == iconToken)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.confidence, confidence) || other.confidence == confidence)&&(identical(other.status, status) || other.status == status)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,studyPlanId,name,code,paperName,colorToken,iconToken,priority,difficulty,confidence,status,sortOrder,createdAt,updatedAt);
}

@override
String toString() {
    return 'Subject(id: $id, studyPlanId: $studyPlanId, name: $name, code: $code, paperName: $paperName, colorToken: $colorToken, iconToken: $iconToken, priority: $priority, difficulty: $difficulty, confidence: $confidence, status: $status, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SubjectCopyWith<$Res> implements $SubjectCopyWith<$Res> {
  factory _$SubjectCopyWith(_Subject value, $Res Function(_Subject) _then) = __$SubjectCopyWithImpl;
@override @useResult
$Res call({
 String id, String studyPlanId, String name, String? code, String? paperName, String colorToken, String iconToken, Priority priority, Difficulty difficulty, Confidence confidence, SubjectStatus status, int sortOrder, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$SubjectCopyWithImpl<$Res>
    implements _$SubjectCopyWith<$Res> {
  __$SubjectCopyWithImpl(this._self, this._then);

  final _Subject _self;
  final $Res Function(_Subject) _then;

/// Create a copy of Subject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? studyPlanId = null,Object? name = null,Object? code = freezed,Object? paperName = freezed,Object? colorToken = null,Object? iconToken = null,Object? priority = null,Object? difficulty = null,Object? confidence = null,Object? status = null,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_Subject(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,studyPlanId: null == studyPlanId ? _self.studyPlanId : studyPlanId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,paperName: freezed == paperName ? _self.paperName : paperName // ignore: cast_nullable_to_non_nullable
as String?,colorToken: null == colorToken ? _self.colorToken : colorToken // ignore: cast_nullable_to_non_nullable
as String,iconToken: null == iconToken ? _self.iconToken : iconToken // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as Priority,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as Confidence,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubjectStatus,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
