import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  Cache._internal();

  static final Cache _instance = Cache._internal();
  late SharedPreferences prefs;

  factory Cache() {
    return _instance;
  }

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // // Cache storage for details
  // final Map<String, SerieDetails> _detailsCache = {};

  // // Method to get details from cache
  // SerieDetails? getDetails(String key) {
  //   return _detailsCache[key];
  // }

  // // Method to set details in cache
  // void setDetails(String id, SerieDetails details) {
  //   _detailsCache[id] = details;
  // }

  Future<void> setBiometrics(bool isEnable) async {
    prefs.setBool("biometric", isEnable);
  }

  bool? isBiometricsEnabled() {
    return prefs.getBool("biometric");
  }
}
