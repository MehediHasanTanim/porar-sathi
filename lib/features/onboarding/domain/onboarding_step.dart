/// Saved setup position. Startup sends the student here until setup is done.
enum OnboardingStep {
  language,
  welcome,
  studyType,
  profile,
  plan,
  exam,
  availability,
  studyTime,
  preferences,
  summary,
  notifications,
  complete;

  String get code => name;

  String get route => switch (this) {
    OnboardingStep.language => '/onboarding/language',
    OnboardingStep.welcome => '/onboarding/welcome',
    OnboardingStep.studyType => '/onboarding/study-type',
    OnboardingStep.profile => '/onboarding/profile',
    OnboardingStep.plan => '/onboarding/plan',
    OnboardingStep.exam => '/onboarding/exam',
    OnboardingStep.availability => '/onboarding/availability',
    OnboardingStep.studyTime => '/onboarding/study-time',
    OnboardingStep.preferences => '/onboarding/preferences',
    OnboardingStep.summary => '/onboarding/summary',
    OnboardingStep.notifications => '/onboarding/notifications',
    OnboardingStep.complete => '/onboarding/complete',
  };

  /// Progress label from the onboarding board. Study type has no counter.
  (int current, int total)? get progress => switch (this) {
    OnboardingStep.profile => (1, 7),
    OnboardingStep.plan => (2, 7),
    OnboardingStep.exam => (3, 7),
    OnboardingStep.availability => (5, 7),
    OnboardingStep.studyTime => (6, 7),
    OnboardingStep.preferences => (7, 7),
    _ => null,
  };

  bool get requiresPlan => index >= OnboardingStep.exam.index;

  OnboardingStep? get previous => switch (this) {
    OnboardingStep.language => null,
    OnboardingStep.welcome => OnboardingStep.language,
    OnboardingStep.studyType => OnboardingStep.welcome,
    OnboardingStep.profile => OnboardingStep.studyType,
    OnboardingStep.plan => OnboardingStep.profile,
    OnboardingStep.exam => OnboardingStep.plan,
    OnboardingStep.availability => OnboardingStep.exam,
    OnboardingStep.studyTime => OnboardingStep.availability,
    OnboardingStep.preferences => OnboardingStep.studyTime,
    OnboardingStep.summary => OnboardingStep.preferences,
    OnboardingStep.notifications => OnboardingStep.summary,
    OnboardingStep.complete => OnboardingStep.notifications,
  };

  static OnboardingStep fromCode(String? code) {
    for (final step in values) {
      if (step.code == code) {
        return step;
      }
    }
    return OnboardingStep.language;
  }

  static OnboardingStep? fromLocation(String location) {
    for (final step in values) {
      if (step.route == location) {
        return step;
      }
    }
    return null;
  }

  static bool isOnboardingLocation(String location) {
    return location == '/onboarding' || location.startsWith('/onboarding/');
  }
}

/// Where to resume. A later step without a saved plan falls back to plan
/// creation so startup never opens a summary that has nothing to show.
OnboardingStep resumeOnboardingStep({
  required String stepCode,
  required bool hasActivePlan,
}) {
  final step = OnboardingStep.fromCode(stepCode);
  if (step.requiresPlan && !hasActivePlan) {
    return OnboardingStep.plan;
  }
  return step;
}
