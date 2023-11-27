import 'dart:convert';

import 'package:authentication/model/user.dart';
import 'package:authentication/utils/storage_key.dart';
import 'package:network/network.dart';
import 'package:storage/secure_storage.dart';

abstract class AuthenticationRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> saveAuthenticatedUser({required User user});
  Future<User?> getAuthenticatedUser();
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl(
      {required this.client, required this.secureStorageService});

  final HttpNetwork client;
  final SecureStorageService secureStorageService;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> body = {"email": email, "password": password};
    Map<String, dynamic> response =
        await client.post(const URLResolver(path: "user/login"), body);
    dynamic data = response["data"];
    return User(
      id: data["id"],
      name: data["name"],
      emailVerifiedAt: DateTime.tryParse(data["email_verified_at"] ?? ""),
      accessToken: response["access_token"],
      tokenType: response["token_type"],
    );
  }

  @override
  Future<void> saveAuthenticatedUser({required User user}) async {
    String jsonData = json.encode(user.toJson());
    await secureStorageService.writeValue(
        StorageKey.authenticatedUser, jsonData);
  }

  @override
  Future<User?> getAuthenticatedUser() async {
    String? jsonString =
        await secureStorageService.readValue(StorageKey.authenticatedUser);
    if (jsonString != null) {
      try {
        Map<String, dynamic> userJson = jsonDecode(jsonString);
        return User.fromJson(userJson);
      } catch (e) {
        return null;
      }
    }

    return null;
  }
}
