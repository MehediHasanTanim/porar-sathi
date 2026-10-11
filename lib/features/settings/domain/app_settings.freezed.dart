// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

 AppLanguage get language; AppThemePreference get theme; bool get onboardingComplete; FirstDayOfWeek get firstDayOfWeek; String? get currentStudyPlanId; int get defaultSessionDuration; int get planningBuffer; bool get autoReplanEnabled;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.language, _this.language) || other.language == _this.language)&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.onboardingComplete, _this.onboardingComplete) || other.onboardingComplete == _this.onboardingComplete)&&(identical(other.firstDayOfWeek, _this.firstDayOfWeek) || other.firstDayOfWeek == _this.firstDayOfWeek)&&(identical(other.currentStudyPlanId, _this.currentStudyPlanId) || other.currentStudyPlanId == _this.currentStudyPlanId)&&(identical(other.defaultSessionDuration, _this.defaultSessionDuration) || other.defaultSessionDuration == _this.defaultSessionDuration)&&(identical(other.planningBuffer, _this.planningBuffer) || other.planningBuffer == _this.planningBuffer)&&(identical(other.autoReplanEnabled, _this.autoReplanEnabled) || other.autoReplanEnabled == _this.autoReplanEnabled));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.language,_this.theme,_this.onboardingComplete,_this.firstDayOfWeek,_this.currentStudyPlanId,_this.defaultSessionDuration,_this.planningBuffer,_this.autoReplanEnabled);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(language: ${_this.language}, theme: ${_this.theme}, onboardingComplete: ${_this.onboardingComplete}, firstDayOfWeek: ${_this.firstDayOfWeek}, currentStudyPlanId: ${_this.currentStudyPlanId}, defaultSessionDuration: ${_this.defaultSessionDuration}, planningBuffer: ${_this.planningBuffer}, autoReplanEnabled: ${_this.autoReplanEnabled})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 AppLanguage language, AppThemePreference theme, bool onboardingComplete, FirstDayOfWeek firstDayOfWeek, String? currentStudyPlanId, int defaultSessionDuration, int planningBuffer, bool autoReplanEnabled
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? theme = null,Object? onboardingComplete = null,Object? firstDayOfWeek = null,Object? currentStudyPlanId = freezed,Object? defaultSessionDuration = null,Object? planningBuffer = null,Object? autoReplanEnabled = null,}) {
  return _then(AppSettings(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemePreference,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,firstDayOfWeek: null == firstDayOfWeek ? _self.firstDayOfWeek : firstDayOfWeek // ignore: cast_nullable_to_non_nullable
as FirstDayOfWeek,currentStudyPlanId: freezed == currentStudyPlanId ? _self.currentStudyPlanId : currentStudyPlanId // ignore: cast_nullable_to_non_nullable
as String?,defaultSessionDuration: null == defaultSessionDuration ? _self.defaultSessionDuration : defaultSessionDuration // ignore: cast_nullable_to_non_nullable
as int,planningBuffer: null == planningBuffer ? _self.planningBuffer : planningBuffer // ignore: cast_nullable_to_non_nullable
as int,autoReplanEnabled: null == autoReplanEnabled ? _self.autoReplanEnabled : autoReplanEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppLanguage language,  AppThemePreference theme,  bool onboardingComplete,  FirstDayOfWeek firstDayOfWeek,  String? currentStudyPlanId,  int defaultSessionDuration,  int planningBuffer,  bool autoReplanEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.language,_that.theme,_that.onboardingComplete,_that.firstDayOfWeek,_that.currentStudyPlanId,_that.defaultSessionDuration,_that.planningBuffer,_that.autoReplanEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppLanguage language,  AppThemePreference theme,  bool onboardingComplete,  FirstDayOfWeek firstDayOfWeek,  String? currentStudyPlanId,  int defaultSessionDuration,  int planningBuffer,  bool autoReplanEnabled)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.language,_that.theme,_that.onboardingComplete,_that.firstDayOfWeek,_that.currentStudyPlanId,_that.defaultSessionDuration,_that.planningBuffer,_that.autoReplanEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppLanguage language,  AppThemePreference theme,  bool onboardingComplete,  FirstDayOfWeek firstDayOfWeek,  String? currentStudyPlanId,  int defaultSessionDuration,  int planningBuffer,  bool autoReplanEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.language,_that.theme,_that.onboardingComplete,_that.firstDayOfWeek,_that.currentStudyPlanId,_that.defaultSessionDuration,_that.planningBuffer,_that.autoReplanEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({required this.language, required this.theme, required this.onboardingComplete, required this.firstDayOfWeek, this.currentStudyPlanId, required this.defaultSessionDuration, required this.planningBuffer, required this.autoReplanEnabled});
  

@override final  AppLanguage language;
@override final  AppThemePreference theme;
@override final  bool onboardingComplete;
@override final  FirstDayOfWeek firstDayOfWeek;
@override final  String? currentStudyPlanId;
@override final  int defaultSessionDuration;
@override final  int planningBuffer;
@override final  bool autoReplanEnabled;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.language, language) || other.language == language)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.onboardingComplete, onboardingComplete) || other.onboardingComplete == onboardingComplete)&&(identical(other.firstDayOfWeek, firstDayOfWeek) || other.firstDayOfWeek == firstDayOfWeek)&&(identical(other.currentStudyPlanId, currentStudyPlanId) || other.currentStudyPlanId == currentStudyPlanId)&&(identical(other.defaultSessionDuration, defaultSessionDuration) || other.defaultSessionDuration == defaultSessionDuration)&&(identical(other.planningBuffer, planningBuffer) || other.planningBuffer == planningBuffer)&&(identical(other.autoReplanEnabled, autoReplanEnabled) || other.autoReplanEnabled == autoReplanEnabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,language,theme,onboardingComplete,firstDayOfWeek,currentStudyPlanId,defaultSessionDuration,planningBuffer,autoReplanEnabled);
}

@override
String toString() {
    return 'AppSettings(language: $language, theme: $theme, onboardingComplete: $onboardingComplete, firstDayOfWeek: $firstDayOfWeek, currentStudyPlanId: $currentStudyPlanId, defaultSessionDuration: $defaultSessionDuration, planningBuffer: $planningBuffer, autoReplanEnabled: $autoReplanEnabled)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 AppLanguage language, AppThemePreference theme, bool onboardingComplete, FirstDayOfWeek firstDayOfWeek, String? currentStudyPlanId, int defaultSessionDuration, int planningBuffer, bool autoReplanEnabled
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? theme = null,Object? onboardingComplete = null,Object? firstDayOfWeek = null,Object? currentStudyPlanId = freezed,Object? defaultSessionDuration = null,Object? planningBuffer = null,Object? autoReplanEnabled = null,}) {
  return _then(_AppSettings(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemePreference,onboardingComplete: null == onboardingComplete ? _self.onboardingComplete : onboardingComplete // ignore: cast_nullable_to_non_nullable
as bool,firstDayOfWeek: null == firstDayOfWeek ? _self.firstDayOfWeek : firstDayOfWeek // ignore: cast_nullable_to_non_nullable
as FirstDayOfWeek,currentStudyPlanId: freezed == currentStudyPlanId ? _self.currentStudyPlanId : currentStudyPlanId // ignore: cast_nullable_to_non_nullable
as String?,defaultSessionDuration: null == defaultSessionDuration ? _self.defaultSessionDuration : defaultSessionDuration // ignore: cast_nullable_to_non_nullable
as int,planningBuffer: null == planningBuffer ? _self.planningBuffer : planningBuffer // ignore: cast_nullable_to_non_nullable
as int,autoReplanEnabled: null == autoReplanEnabled ? _self.autoReplanEnabled : autoReplanEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
