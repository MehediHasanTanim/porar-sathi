/// Sections written into `data.json`. Every key is required, even when empty.
const backupSections = [
  'studentProfiles',
  'studyPlans',
  'subjects',
  'chapters',
  'exams',
  'examSyllabusItems',
  'weeklyAvailability',
  'calendarExceptions',
  'studyTasks',
  'studySessions',
  'revisionSchedules',
  'plannerRuns',
];

const backupSchemaVersion = 2;
const backupAppVersion = '1.0.0';
const backupContentsLabel = 'study data';
const backupFileExtension = 'pockettutor';

/// Unencrypted files include this sentence so the archive is visibly study data.
const backupReadme =
    'Porar Sathi / Pocket Tutor backup.\n'
    'This file contains study data from your device.\n'
    'A standard backup is not encrypted.\n';

enum BackupProblem {
  fileType,
  partial,
  olderSchema,
  newerSchema,
  checksum,
  missingSection,
  relationship,
  wrongPassword,
  corrupt,
}

final class BackupManifest {
  const BackupManifest({
    required this.schemaVersion,
    required this.appVersion,
    required this.createdAt,
    required this.locale,
    required this.checksum,
    required this.devicePlatform,
    required this.contents,
  });

  final int schemaVersion;
  final String appVersion;
  final DateTime createdAt;
  final String locale;
  final String checksum;
  final String devicePlatform;
  final String contents;
}

final class BackupPayload {
  const BackupPayload(this.sections);

  final Map<String, List<Map<String, dynamic>>> sections;

  List<Map<String, dynamic>> rows(String section) =>
      sections[section] ?? const [];
}

final class BackupSummary {
  const BackupSummary({
    required this.createdAt,
    required this.locale,
    required this.appVersion,
    required this.plans,
    required this.subjects,
    required this.sessions,
    required this.encrypted,
  });

  final DateTime createdAt;
  final String locale;
  final String appVersion;
  final int plans;
  final int subjects;
  final int sessions;
  final bool encrypted;
}

sealed class BackupInspection {
  const BackupInspection();
}

final class BackupAccepted extends BackupInspection {
  const BackupAccepted({
    required this.manifest,
    required this.payload,
    required this.summary,
  });

  final BackupManifest manifest;
  final BackupPayload payload;
  final BackupSummary summary;
}

final class BackupRejected extends BackupInspection {
  const BackupRejected(this.problem);

  final BackupProblem problem;
}

BackupProblem? validatePayload(BackupPayload payload) {
  final sections = payload.sections;
  for (final name in backupSections) {
    if (!sections.containsKey(name)) {
      return BackupProblem.missingSection;
    }
  }
  final ids = <String, Set<String>>{};
  for (final name in backupSections) {
    final rows = sections[name]!;
    final seen = <String>{};
    for (final row in rows) {
      final id = row['id'];
      if (id is! String || id.isEmpty || !seen.add(id)) {
        return BackupProblem.relationship;
      }
    }
    ids[name] = seen;
  }

  bool has(String section, Object? id) {
    return id is String && (ids[section]?.contains(id) ?? false);
  }

  bool optional(String section, Object? id) => id == null || has(section, id);

  for (final row in sections['subjects']!) {
    if (!has('studyPlans', row['studyPlanId'])) {
      return BackupProblem.relationship;
    }
  }
  final subjectPlan = {
    for (final row in sections['subjects']!)
      row['id'] as String: row['studyPlanId'],
  };
  for (final row in sections['chapters']!) {
    if (!has('subjects', row['subjectId'])) {
      return BackupProblem.relationship;
    }
  }
  final chapterSubject = {
    for (final row in sections['chapters']!)
      row['id'] as String: row['subjectId'],
  };
  for (final row in sections['exams']!) {
    if (!has('studyPlans', row['studyPlanId'])) {
      return BackupProblem.relationship;
    }
  }
  for (final row in sections['studyPlans']!) {
    final examId = row['primaryExamId'];
    if (examId == null) {
      continue;
    }
    final exam = sections['exams']!
        .where((item) => item['id'] == examId)
        .firstOrNull;
    if (exam == null || exam['studyPlanId'] != row['id']) {
      return BackupProblem.relationship;
    }
  }
  for (final row in sections['examSyllabusItems']!) {
    if (!has('exams', row['examId']) || !has('subjects', row['subjectId'])) {
      return BackupProblem.relationship;
    }
    if (!optional('chapters', row['chapterId'])) {
      return BackupProblem.relationship;
    }
  }
  final availability = <String>{};
  for (final row in sections['weeklyAvailability']!) {
    final weekday = row['weekday'];
    if (!has('studyPlans', row['studyPlanId']) ||
        weekday is! int ||
        weekday < 1 ||
        weekday > 7) {
      return BackupProblem.relationship;
    }
    if (!availability.add('${row['studyPlanId']}:$weekday')) {
      return BackupProblem.relationship;
    }
  }
  final exceptions = <String>{};
  for (final row in sections['calendarExceptions']!) {
    if (!has('studyPlans', row['studyPlanId']) ||
        row['exceptionDate'] == null) {
      return BackupProblem.relationship;
    }
    if (!exceptions.add('${row['studyPlanId']}:${row['exceptionDate']}')) {
      return BackupProblem.relationship;
    }
  }
  for (final row in sections['studyTasks']!) {
    if (!has('studyPlans', row['studyPlanId']) ||
        !has('subjects', row['subjectId'])) {
      return BackupProblem.relationship;
    }
    if (subjectPlan[row['subjectId']] != row['studyPlanId']) {
      return BackupProblem.relationship;
    }
    if (!optional('chapters', row['chapterId']) ||
        !optional('exams', row['examId'])) {
      return BackupProblem.relationship;
    }
    final chapterId = row['chapterId'];
    if (chapterId != null &&
        subjectPlan[chapterSubject[chapterId]] != row['studyPlanId']) {
      return BackupProblem.relationship;
    }
  }
  for (final row in sections['studySessions']!) {
    if (!has('subjects', row['subjectId'])) {
      return BackupProblem.relationship;
    }
    if (!optional('studyTasks', row['studyTaskId']) ||
        !optional('chapters', row['chapterId'])) {
      return BackupProblem.relationship;
    }
  }
  for (final row in sections['revisionSchedules']!) {
    if (!has('studyPlans', row['studyPlanId']) ||
        !has('chapters', row['chapterId'])) {
      return BackupProblem.relationship;
    }
    if (!optional('studySessions', row['sourceStudySessionId'])) {
      return BackupProblem.relationship;
    }
  }
  for (final row in sections['plannerRuns']!) {
    if (!has('studyPlans', row['studyPlanId'])) {
      return BackupProblem.relationship;
    }
  }
  return null;
}

BackupPayload emptyBackupPayload() {
  return BackupPayload({
    for (final section in backupSections) section: <Map<String, dynamic>>[],
  });
}
