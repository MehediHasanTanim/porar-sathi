import 'package:porar_sathi/core/repository/repository.dart';
import 'package:porar_sathi/features/onboarding/domain/student_profile.dart';

abstract interface class StudentProfileRepository implements Repository {
  Future<StudentProfile?> findById(String id);

  Stream<List<StudentProfile>> watchAll();

  Future<StudentProfile> save(StudentProfile profile);

  Future<void> delete(String id);
}
