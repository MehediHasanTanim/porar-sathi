// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsController)
final settingsControllerProvider = SettingsControllerProvider._();

final class SettingsControllerProvider
    extends $AsyncNotifierProvider<SettingsController, AppSettings> {
  SettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsControllerHash();

  @$internal
  @override
  SettingsController create() => SettingsController();
}

String _$settingsControllerHash() =>
    r'6c03e6362ef731c982923849855bab90bb117b9d';

abstract class _$SettingsController extends $AsyncNotifier<AppSettings> {
  FutureOr<AppSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppSettings>, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppSettings>, AppSettings>,
              AsyncValue<AppSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
