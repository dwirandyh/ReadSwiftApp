import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  Future<String?> readValue(String key);
  Future<Map<String, String>> readAllValues();
  Future<void> deleteValue(String key);
  Future<void> deleteAllValues();
  Future<void> writeValue(String key, String value);

  static SecureStorageService instance() {
    return SecureStorageServiceImpl();
  }
}

class SecureStorageServiceImpl implements SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<String?> readValue(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<Map<String, String>> readAllValues() async {
    return await _storage.readAll();
  }

  @override
  Future<void> deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAllValues() async {
    await _storage.deleteAll();
  }

  @override
  Future<void> writeValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
