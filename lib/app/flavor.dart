enum AppFlavor {
  development,
  staging,
  production;

  bool get isProduction => this == AppFlavor.production;

  String get bannerLabel => switch (this) {
    AppFlavor.development => 'DEV',
    AppFlavor.staging => 'STG',
    AppFlavor.production => '',
  };

  /// Native application id configured for this flavor.
  String get applicationId => switch (this) {
    AppFlavor.development => 'com.porarsathi.app.dev',
    AppFlavor.staging => 'com.porarsathi.app.staging',
    AppFlavor.production => 'com.porarsathi.app',
  };
}
