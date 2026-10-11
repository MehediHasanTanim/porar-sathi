import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/syllabus/domain/chapter.dart';

abstract interface class ChapterRepository implements Repository {
  Future<Chapter?> findById(String id);

  Stream<List<Chapter>> watchBySubject(String subjectId);

  Future<Chapter> save(Chapter chapter);

  Future<List<Chapter>> saveAll(List<Chapter> chapters);

  /// Study sessions for the chapter block deletion until [includeHistory].
  Future<void> delete(String id, {bool includeHistory = false});
}
