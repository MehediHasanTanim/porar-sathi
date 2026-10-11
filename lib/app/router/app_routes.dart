abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const home = '/home';
  static const today = '/today';
  static const plan = '/plan';
  static const syllabus = '/syllabus';
  static const progress = '/progress';
  static const more = '/more';
  static const settings = '/settings';
  static const appearance = '/appearance';
  static const language = '/language';
  static const newSubject = '/subjects/new';
  static const exams = '/exams';
  static const newExam = '/exams/new';
  static const availability = '/availability';
  static const newException = '/exceptions/new';
  static const session = '/session';
  static const finishSession = '/session/finish';
  static const quickStudy = '/quick-study';

  static String subject(String id) => '/subjects/$id';
  static String editSubject(String id) => '/subjects/$id/edit';
  static String chapters(String subjectId) => '/subjects/$subjectId/chapters';
  static String exam(String id) => '/exams/$id';
  static String task(String id) => '/tasks/$id';
  static String completeTask(String id) => '/tasks/$id/complete';
  static String partialTask(String id) => '/tasks/$id/partial';
  static String moveTask(String id) => '/tasks/$id/move';
}
