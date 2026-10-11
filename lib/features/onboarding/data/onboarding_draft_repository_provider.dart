import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/features/onboarding/data/onboarding_draft_repository.dart';

part 'onboarding_draft_repository_provider.g.dart';

@Riverpod(keepAlive: true)
OnboardingDraftRepository onboardingDraftRepository(Ref ref) {
  throw StateError(
    'Override onboardingDraftRepositoryProvider before the app starts.',
  );
}
