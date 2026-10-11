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

  static String subject(String id) => '/subjects/$id';
  static String editSubject(String id) => '/subjects/$id/edit';
  static String chapters(String subjectId) => '/subjects/$subjectId/chapters';
  static String exam(String id) => '/exams/$id';
}
