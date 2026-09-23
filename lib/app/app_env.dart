enum AppEnvironment { dev, staging, prod }

class AppEnv {
  static late AppEnvironment currentEnv;
  static late String baseUrl;
  static late bool enableLogging;

  static void init({
    AppEnvironment environment = AppEnvironment.dev,
    String? customBaseUrl,
    bool enableLogger = true,
  }) {
    currentEnv = environment;
    enableLogging = enableLogger;

    switch (environment) {
      case AppEnvironment.dev:
        baseUrl = customBaseUrl ?? 'https://dummyjson.com';
        break;
      case AppEnvironment.staging:
        baseUrl = customBaseUrl ?? 'https://staging-api.dummyjson.com';
        break;
      case AppEnvironment.prod:
        baseUrl = customBaseUrl ?? 'https://dummyjson.com';
        break;
    }
  }
}
