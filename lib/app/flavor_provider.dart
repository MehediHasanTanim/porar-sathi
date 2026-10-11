import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:porar_sathi/app/flavor.dart';

part 'flavor_provider.g.dart';

@Riverpod(keepAlive: true)
AppFlavor appFlavor(Ref ref) => AppFlavor.production;
