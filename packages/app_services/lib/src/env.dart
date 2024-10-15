abstract class Env {
  static String get apiBaseUrl => const String.fromEnvironment("DEFINE_API_URL");
  static String get token => const String.fromEnvironment("DEFINE_TOKEN");
  static String get oneSignalAPIKey => const String.fromEnvironment("DEFINE_ONE_SIGNAL_API_KEY");
}
