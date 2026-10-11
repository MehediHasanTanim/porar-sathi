import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:porar_sathi/app/flavor_provider.dart';
import 'package:porar_sathi/app/router/app_router.dart';
import 'package:porar_sathi/app/theme/app_theme.dart';
import 'package:porar_sathi/features/notifications/application/notification_providers.dart';
import 'package:porar_sathi/features/settings/application/settings_controller.dart';
import 'package:porar_sathi/l10n/app_localizations.dart';

class PorarSathiApp extends ConsumerWidget {
  const PorarSathiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final settings = ref.watch(settingsControllerProvider).asData?.value;
    final flavor = ref.watch(appFlavorProvider);
    final scheduler = ref.read(notificationSchedulerProvider);
    scheduler.onSelected = (payload) {
      if (payload != null && payload.startsWith('/')) {
        router.go(payload);
      }
    };
    final launchPayload = scheduler.takeLaunchPayload();
    if (launchPayload != null && launchPayload.startsWith('/')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        router.go(launchPayload);
      });
    }

    final reduceMotion =
        (settings?.reducedMotion ?? false) ||
        WidgetsBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .disableAnimations;

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(reducedMotion: reduceMotion),
      darkTheme: AppTheme.dark(reducedMotion: reduceMotion),
      themeMode: settings?.theme.materialThemeMode ?? ThemeMode.system,
      locale: settings?.language.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        var content = child ?? const SizedBox.shrink();
        if (reduceMotion && !media.disableAnimations) {
          content = MediaQuery(
            data: media.copyWith(disableAnimations: true),
            child: content,
          );
        }
        if (flavor.isProduction) {
          return content;
        }
        return Banner(
          message: flavor.bannerLabel,
          location: BannerLocation.topEnd,
          color: const Color(0xFFD97706),
          child: content,
        );
      },
    );
  }
}
