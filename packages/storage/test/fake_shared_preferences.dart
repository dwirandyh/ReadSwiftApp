import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class FakeSharedPreferences implements SharedPreferences {
  Map<String, dynamic> _prefs = {};

  @override
  Future<bool> clear() {
    _prefs.clear();
    return Future.value(true); // Simulate successful clear operation
  }

  @override
  Future<bool> commit() {
    // Not applicable for in-memory storage, return true to simulate success
    return Future.value(true);
  }

  @override
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  @override
  Object? get(String key) {
    return _prefs[key];
  }

  @override
  bool? getBool(String key) {
    return _prefs[key];
  }

  @override
  double? getDouble(String key) {
    return _prefs[key];
  }

  @override
  int? getInt(String key) {
    return _prefs[key];
  }

  @override
  Set<String> getKeys() {
    return _prefs.keys.toSet();
  }

  @override
  String? getString(String key) {
    return _prefs[key];
  }

  @override
  List<String>? getStringList(String key) {
    return _prefs[key];
  }

  @override
  Future<void> reload() {
    // Not applicable for in-memory storage, no action needed
    return Future.value();
  }

  @override
  Future<bool> remove(String key) {
    _prefs.remove(key);
    return Future.value(true); // Simulate successful remove operation
  }

  @override
  Future<bool> setBool(String key, bool value) {
    _prefs[key] = value;
    return Future.value(true); // Simulate successful set operation
  }

  @override
  Future<bool> setDouble(String key, double value) {
    _prefs[key] = value;
    return Future.value(true); // Simulate successful set operation
  }

  @override
  Future<bool> setInt(String key, int value) {
    _prefs[key] = value;
    return Future.value(true); // Simulate successful set operation
  }

  @override
  Future<bool> setString(String key, String value) {
    _prefs[key] = value;
    return Future.value(true); // Simulate successful set operation
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    _prefs[key] = value;
    return Future.value(true); // Simulate successful set operation
  }
}
