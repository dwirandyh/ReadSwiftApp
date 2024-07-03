import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/preference_key.dart';

abstract class SharedPreferenceService {
  Future<void> setValue<T>(PreferenceKey<T> key, T value);
  T getValue<T>(PreferenceKey<T> key);
  Future<void> remove<T>(PreferenceKey<T> key);
  Future<void> clear();

  static Future<SharedPreferenceService> instance() async {
    final service = SharedPreferenceServiceImpl();
    await service.init(await SharedPreferences.getInstance());
    return service;
  }
}

class SharedPreferenceServiceImpl extends SharedPreferenceService {
  SharedPreferences? _preferences;

  Future<void> init(SharedPreferences preferences) async {
    _preferences = preferences;
  }

  @override
  Future<void> setValue<T>(PreferenceKey<T> key, T value) async {
    if (_preferences == null) {
      throw Exception('SharedPreferenceService not initialized');
    }
    if (value is String) {
      await _preferences?.setString(key.key, value);
    } else if (value is int) {
      await _preferences?.setInt(key.key, value);
    } else if (value is double) {
      await _preferences?.setDouble(key.key, value);
    } else if (value is bool) {
      await _preferences?.setBool(key.key, value);
    } else if (value is List<String>) {
      await _preferences?.setStringList(key.key, value);
    } else {
      throw UnsupportedError('Type not supported');
    }
  }

  @override
  T getValue<T>(PreferenceKey<T> key) {
    if (T == String) {
      return (_preferences?.getString(key.key) ?? key.defaultValue) as T;
    } else if (T == int) {
      return (_preferences?.getInt(key.key) ?? key.defaultValue) as T;
    } else if (T == bool) {
      return (_preferences?.getBool(key.key) ?? key.defaultValue) as T;
    } else if (T == double) {
      return (_preferences?.getDouble(key.key) ?? key.defaultValue) as T;
    } else if (T == List<String>) {
      return (_preferences?.getStringList(key.key) ?? key.defaultValue) as T;
    } else {
      return key.defaultValue;
    }
  }

  @override
  Future<void> remove<T>(PreferenceKey<T> key) async {
    await _preferences?.remove(key.key);
  }

  @override
  Future<void> clear() async {
    await _preferences?.clear();
  }
}
