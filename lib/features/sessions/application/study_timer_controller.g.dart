// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_timer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StudyTimerController)
final studyTimerControllerProvider = StudyTimerControllerProvider._();

final class StudyTimerControllerProvider
    extends $AsyncNotifierProvider<StudyTimerController, ActiveStudyTimer?> {
  StudyTimerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'studyTimerControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$studyTimerControllerHash();

  @$internal
  @override
  StudyTimerController create() => StudyTimerController();
}

String _$studyTimerControllerHash() =>
    r'dbeaaccc295d7564f692efb1bae9f8ac96655e6b';

abstract class _$StudyTimerController
    extends $AsyncNotifier<ActiveStudyTimer?> {
  FutureOr<ActiveStudyTimer?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ActiveStudyTimer?>, ActiveStudyTimer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ActiveStudyTimer?>, ActiveStudyTimer?>,
              AsyncValue<ActiveStudyTimer?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
