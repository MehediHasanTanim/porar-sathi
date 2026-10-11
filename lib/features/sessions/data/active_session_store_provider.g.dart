// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_session_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeSessionStore)
final activeSessionStoreProvider = ActiveSessionStoreProvider._();

final class ActiveSessionStoreProvider
    extends
        $FunctionalProvider<
          AsyncValue<ActiveSessionStore>,
          ActiveSessionStore,
          FutureOr<ActiveSessionStore>
        >
    with
        $FutureModifier<ActiveSessionStore>,
        $FutureProvider<ActiveSessionStore> {
  ActiveSessionStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeSessionStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeSessionStoreHash();

  @$internal
  @override
  $FutureProviderElement<ActiveSessionStore> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ActiveSessionStore> create(Ref ref) {
    return activeSessionStore(ref);
  }
}

String _$activeSessionStoreHash() =>
    r'a60872561f4e97b43fe8c960b76403bdd7a395f1';
