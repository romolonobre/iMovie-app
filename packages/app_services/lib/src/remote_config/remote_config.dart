import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';

export 'remote_config_visibility_widget.dart';

class CustomRemoteConfig {
  late FirebaseRemoteConfig _firebaseRemoteConfig;
  factory CustomRemoteConfig() => _singleton;

  CustomRemoteConfig._internal();
  static final CustomRemoteConfig _singleton = CustomRemoteConfig._internal();

  Future<void> initialize() async {
    _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    await _firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await forceFetch();
  }

  Future<void> forceFetch() async {
    try {
      await _firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await _firebaseRemoteConfig.fetchAndActivate();
    } on PlatformException catch (exception) {
      throw exception.toString();
    } catch (exception) {
      throw 'Error getting remote flags. Error: $exception';
    }
  }

  dynamic getValueOrDefault({
    required String key,
    required dynamic defaultValue,
  }) {
    switch (defaultValue.runtimeType) {
      case String:
        final value = _firebaseRemoteConfig.getString(key);
        return value != '' ? value : defaultValue;
      case int:
        final value = _firebaseRemoteConfig.getInt(key);
        return value != 0 ? value : defaultValue;
      case bool:
        final value = _firebaseRemoteConfig.getBool(key);
        return value;
      case double:
        final value = _firebaseRemoteConfig.getDouble(key);
        return value != 0.0 ? value : defaultValue;
      default:
        return Exception('Implementation not found');
    }
  }
}
