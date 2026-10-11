import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'id_generator.g.dart';

abstract interface class IdGenerator {
  String next();
}

final class UuidIdGenerator implements IdGenerator {
  const UuidIdGenerator();

  static const _uuid = Uuid();

  @override
  String next() => _uuid.v4();
}

@Riverpod(keepAlive: true)
IdGenerator idGenerator(Ref ref) => const UuidIdGenerator();
