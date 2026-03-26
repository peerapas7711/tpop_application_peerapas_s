enum AppFlavor { staging, prod }

enum MockDataState { success, empty, error }

class FirebaseEnvironmentConfig {
  const FirebaseEnvironmentConfig({
    required this.projectId,
    required this.appId,
    required this.messagingSenderId,
    required this.apiKey,
  });

  final String projectId;
  final String appId;
  final String messagingSenderId;
  final String apiKey;
}

class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.appName,
    required this.apiBaseUrl,
    required this.firebaseConfig,
    required this.packagesState,
    required this.historyState,
  });

  final AppFlavor flavor;
  final String appName;
  final String apiBaseUrl;
  final FirebaseEnvironmentConfig firebaseConfig;
  final MockDataState packagesState;
  final MockDataState historyState;

  factory AppEnvironment.fromDefines() {
    final flavor = _parseFlavor(
      const String.fromEnvironment('APP_ENV', defaultValue: 'staging'),
    );
    return _build(flavor);
  }

  factory AppEnvironment.staging() => _build(AppFlavor.staging);

  factory AppEnvironment.prod() => _build(AppFlavor.prod);

  static AppEnvironment _build(AppFlavor flavor) {
    final isProduction = flavor == AppFlavor.prod;

    return AppEnvironment(
      flavor: flavor,
      appName: isProduction ? 'T-POP' : 'T-POP Staging',
      apiBaseUrl:
          isProduction
              ? const String.fromEnvironment(
                'API_BASE_URL',
                defaultValue: 'https://api.t-pop.app',
              )
              : const String.fromEnvironment(
                'API_BASE_URL',
                defaultValue: 'https://staging-api.t-pop.app',
              ),
      firebaseConfig: FirebaseEnvironmentConfig(
        projectId:
            isProduction
                ? const String.fromEnvironment(
                  'FIREBASE_PROJECT_ID',
                  defaultValue: 'tpop-prod-placeholder',
                )
                : const String.fromEnvironment(
                  'FIREBASE_PROJECT_ID',
                  defaultValue: 'tpop-staging-placeholder',
                ),
        appId: const String.fromEnvironment(
          'FIREBASE_APP_ID',
          defaultValue: 'pending-firebase-app-id',
        ),
        messagingSenderId: const String.fromEnvironment(
          'FIREBASE_SENDER_ID',
          defaultValue: 'pending-sender-id',
        ),
        apiKey: const String.fromEnvironment(
          'FIREBASE_API_KEY',
          defaultValue: 'pending-api-key',
        ),
      ),
      packagesState: _parseState(
        const String.fromEnvironment('PACKAGES_STATE', defaultValue: 'success'),
      ),
      historyState: _parseState(
        const String.fromEnvironment('HISTORY_STATE', defaultValue: 'success'),
      ),
    );
  }

  static AppFlavor _parseFlavor(String value) {
    switch (value.toLowerCase()) {
      case 'prod':
      case 'production':
        return AppFlavor.prod;
      case 'staging':
      default:
        return AppFlavor.staging;
    }
  }

  static MockDataState _parseState(String value) {
    switch (value.toLowerCase()) {
      case 'empty':
        return MockDataState.empty;
      case 'error':
        return MockDataState.error;
      case 'success':
      default:
        return MockDataState.success;
    }
  }
}
