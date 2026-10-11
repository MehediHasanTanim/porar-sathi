// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentProfile {

 String get id; String get displayName; StudyLevel get studyLevel; String? get institution; String? get academicYear; AppLanguage get preferredLanguage; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentProfileCopyWith<StudentProfile> get copyWith => _$StudentProfileCopyWithImpl<StudentProfile>(this as StudentProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudentProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentProfile&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName)&&(identical(other.studyLevel, _this.studyLevel) || other.studyLevel == _this.studyLevel)&&(identical(other.institution, _this.institution) || other.institution == _this.institution)&&(identical(other.academicYear, _this.academicYear) || other.academicYear == _this.academicYear)&&(identical(other.preferredLanguage, _this.preferredLanguage) || other.preferredLanguage == _this.preferredLanguage)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as StudentProfile;
  return Object.hash(runtimeType,_this.id,_this.displayName,_this.studyLevel,_this.institution,_this.academicYear,_this.preferredLanguage,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as StudentProfile;
  return 'StudentProfile(id: ${_this.id}, displayName: ${_this.displayName}, studyLevel: ${_this.studyLevel}, institution: ${_this.institution}, academicYear: ${_this.academicYear}, preferredLanguage: ${_this.preferredLanguage}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $StudentProfileCopyWith<$Res>  {
  factory $StudentProfileCopyWith(StudentProfile value, $Res Function(StudentProfile) _then) = _$StudentProfileCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, StudyLevel studyLevel, String? institution, String? academicYear, AppLanguage preferredLanguage, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$StudentProfileCopyWithImpl<$Res>
    implements $StudentProfileCopyWith<$Res> {
  _$StudentProfileCopyWithImpl(this._self, this._then);

  final StudentProfile _self;
  final $Res Function(StudentProfile) _then;

/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? studyLevel = null,Object? institution = freezed,Object? academicYear = freezed,Object? preferredLanguage = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(StudentProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,studyLevel: null == studyLevel ? _self.studyLevel : studyLevel // ignore: cast_nullable_to_non_nullable
as StudyLevel,institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentProfile].
extension StudentProfilePatterns on StudentProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentProfile value)  $default,){
final _that = this;
switch (_that) {
case _StudentProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentProfile value)?  $default,){
final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  StudyLevel studyLevel,  String? institution,  String? academicYear,  AppLanguage preferredLanguage,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
return $default(_that.id,_that.displayName,_that.studyLevel,_that.institution,_that.academicYear,_that.preferredLanguage,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  StudyLevel studyLevel,  String? institution,  String? academicYear,  AppLanguage preferredLanguage,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _StudentProfile():
return $default(_that.id,_that.displayName,_that.studyLevel,_that.institution,_that.academicYear,_that.preferredLanguage,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  StudyLevel studyLevel,  String? institution,  String? academicYear,  AppLanguage preferredLanguage,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
return $default(_that.id,_that.displayName,_that.studyLevel,_that.institution,_that.academicYear,_that.preferredLanguage,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _StudentProfile implements StudentProfile {
  const _StudentProfile({required this.id, required this.displayName, required this.studyLevel, this.institution, this.academicYear, required this.preferredLanguage, required this.createdAt, required this.updatedAt});
  

@override final  String id;
@override final  String displayName;
@override final  StudyLevel studyLevel;
@override final  String? institution;
@override final  String? academicYear;
@override final  AppLanguage preferredLanguage;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentProfileCopyWith<_StudentProfile> get copyWith => __$StudentProfileCopyWithImpl<_StudentProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.studyLevel, studyLevel) || other.studyLevel == studyLevel)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.academicYear, academicYear) || other.academicYear == academicYear)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,displayName,studyLevel,institution,academicYear,preferredLanguage,createdAt,updatedAt);
}

@override
String toString() {
    return 'StudentProfile(id: $id, displayName: $displayName, studyLevel: $studyLevel, institution: $institution, academicYear: $academicYear, preferredLanguage: $preferredLanguage, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$StudentProfileCopyWith<$Res> implements $StudentProfileCopyWith<$Res> {
  factory _$StudentProfileCopyWith(_StudentProfile value, $Res Function(_StudentProfile) _then) = __$StudentProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, StudyLevel studyLevel, String? institution, String? academicYear, AppLanguage preferredLanguage, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$StudentProfileCopyWithImpl<$Res>
    implements _$StudentProfileCopyWith<$Res> {
  __$StudentProfileCopyWithImpl(this._self, this._then);

  final _StudentProfile _self;
  final $Res Function(_StudentProfile) _then;

/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? studyLevel = null,Object? institution = freezed,Object? academicYear = freezed,Object? preferredLanguage = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_StudentProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,studyLevel: null == studyLevel ? _self.studyLevel : studyLevel // ignore: cast_nullable_to_non_nullable
as StudyLevel,institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String?,academicYear: freezed == academicYear ? _self.academicYear : academicYear // ignore: cast_nullable_to_non_nullable
as String?,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as AppLanguage,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
