import 'dart:convert';

import 'package:authentication/utils/storage_key.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:network/interceptor/authentication_interceptor.dart';
import 'package:network/network.dart';
import 'package:storage/secure_storage.dart';

abstract class AuthenticationRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> saveAuthenticatedUser({required User user});
  Future<User?> getAuthenticatedUser();
  Future<void> logout();
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
    dynamic userData = response["data"];
    return User(
      id: userData["id"],
      name: userData["name"],
      email: userData["email"],
      emailVerifiedAt: DateTime.tryParse(userData["email_verified_at"] ?? ""),
      accessToken: response["access_token"],
      tokenType: response["token_type"],
    );
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "password": password
    };
    Map<String, dynamic> response =
        await client.post(const URLResolver(path: "user"), body);
    dynamic userData = response["data"];
    return User(
      id: userData["id"],
      name: userData["name"],
      email: userData["email"],
      emailVerifiedAt: DateTime.tryParse(userData["email_verified_at"] ?? ""),
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
        User user = User.fromJson(userJson);
        client.addInterceptor(
          AuthenticationInterceptor(
            tokenType: user.tokenType,
            token: user.accessToken,
          ),
        );
        return user;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  @override
  Future<void> logout() async {
    await secureStorageService.deleteValue(StorageKey.authenticatedUser);
  }
}
