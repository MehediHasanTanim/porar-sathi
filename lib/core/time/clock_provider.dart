import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/core/time/clock.dart';

part 'clock_provider.g.dart';

@Riverpod(keepAlive: true)
Clock clock(Ref ref) => const SystemClock();
