import 'package:porar_sathi/core/domain/academic_enums.dart';
import 'package:porar_sathi/core/time/calendar_date.dart';
import 'package:porar_sathi/features/revision/domain/revision_schedule.dart';

const revisionMinMinutes = 10;
const revisionMaxMinutes = 60;

/// Revision 1 is 25% of the study, revision 2 is 20%, and revision 3 is 15%.
///
/// Low confidence lengthens the session. High confidence shortens it unless
/// the chapter is important for the exam.
int revisionDurationMinutes({
  required int studyMinutes,
  required int revisionNumber,
  required Confidence confidence,
  required Priority examImportance,
}) {
  final ratio = switch (revisionNumber) {
    1 => 25,
    2 => 20,
    _ => 15,
  };
  final base = studyMinutes <= 0 ? revisionMinMinutes : (studyMinutes * ratio / 100).round();
  final important = examImportance == Priority.high || examImportance == Priority.critical;
  final factor = switch (confidence) {
    Confidence.veryLow => 150,
    Confidence.low => 125,
    Confidence.medium => 100,
    Confidence.high || Confidence.veryHigh => important ? 100 : 75,
  };
  var minutes = (base * factor / 100).round();
  if (minutes < revisionMinMinutes) {
    minutes = revisionMinMinutes;
  }
  if (minutes > revisionMaxMinutes) {
    minutes = revisionMaxMinutes;
  }
  return minutes;
}

/// Offsets for each revision. A null offset means the day before the exam.
List<({int number, int? offsetDays})> revisionSteps(RevisionPolicy policy) {
  return switch (policy) {
    RevisionPolicy.standard => const [
      (number: 1, offsetDays: 2),
      (number: 2, offsetDays: 7),
      (number: 3, offsetDays: null),
    ],
    RevisionPolicy.light => const [
      (number: 1, offsetDays: 7),
      (number: 2, offsetDays: null),
    ],
    RevisionPolicy.frequent => const [
      (number: 1, offsetDays: 1),
      (number: 2, offsetDays: 3),
      (number: 3, offsetDays: 7),
    ],
  };
}

/// Builds the revision dates for [policy]. The standard policy is +2 / +7 / before the exam.
///
/// A chapter and revision number that already exists is left alone. A date
/// on or after the exam is dropped.
List<RevisionSchedule> buildRevisionSchedule({
  required String studyPlanId,
  required String chapterId,
  required DateTime studiedOn,
  required int studyMinutes,
  required Confidence confidence,
  required Priority examImportance,
  DateTime? examDate,
  required List<RevisionSchedule> existing,
  required DateTime createdAt,
  required List<String> ids,
  String? sourceStudySessionId,
  RevisionPolicy policy = RevisionPolicy.standard,
}) {
  final studied = calendarDate(studiedOn);
  final exam = examDate == null ? null : calendarDate(examDate);
  final created = <RevisionSchedule>[];
  var idIndex = 0;
  for (final step in revisionSteps(policy)) {
    final number = step.number;
    if (idIndex >= ids.length) {
      break;
    }
    if (_alreadyScheduled(existing, created, chapterId, number)) {
      continue;
    }
    final due = _dueDate(
      offsetDays: step.offsetDays,
      studied: studied,
      exam: exam,
    );
    if (due == null) {
      continue;
    }
    created.add(
      RevisionSchedule(
        id: ids[idIndex],
        studyPlanId: studyPlanId,
        chapterId: chapterId,
        sourceStudySessionId: sourceStudySessionId,
        revisionNumber: number,
        dueDate: due,
        estimatedMinutes: revisionDurationMinutes(
          studyMinutes: studyMinutes,
          revisionNumber: number,
          confidence: confidence,
          examImportance: examImportance,
        ),
        status: RevisionStatus.pending,
        createdAt: createdAt,
      ),
    );
    idIndex += 1;
  }
  return created;
}

bool _alreadyScheduled(
  List<RevisionSchedule> existing,
  List<RevisionSchedule> created,
  String chapterId,
  int number,
) {
  for (final schedule in [...existing, ...created]) {
    if (schedule.chapterId == chapterId && schedule.revisionNumber == number) {
      return true;
    }
  }
  return false;
}

DateTime? _dueDate({
  required int? offsetDays,
  required DateTime studied,
  required DateTime? exam,
}) {
  final due = offsetDays == null
      ? exam?.subtract(const Duration(days: 1))
      : studied.add(Duration(days: offsetDays));
  if (due == null || due.isBefore(studied)) {
    return null;
  }
  if (exam != null && !due.isBefore(exam)) {
    return null;
  }
  return due;
}
