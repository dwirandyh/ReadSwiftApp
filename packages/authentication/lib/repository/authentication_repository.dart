import 'dart:convert';

import 'package:authentication/external/interceptor/authentication_interceptor.dart';
import 'package:authentication/utils/storage_key.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:network/network.dart';
import 'package:storage/secure_storage_service.dart';

abstract class AuthenticationRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> loginWithGoogle({required String accessToken});
  Future<User> loginWithFacebook({required String accessToken});

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
        await client.post(const URLResolver(path: "auth/login"), body: body);
    return _mapJsonToUser(response);
  }

  @override
  Future<User> loginWithGoogle({required String accessToken}) async {
    Map<String, dynamic> body = {"token": accessToken};
    Map<String, dynamic> response = await client
        .post(const URLResolver(path: "auth/google-signin"), body: body);
    return _mapJsonToUser(response);
  }

  @override
  Future<User> loginWithFacebook({required String accessToken}) async {
    Map<String, dynamic> body = {"token": accessToken};
    Map<String, dynamic> response = await client
        .post(const URLResolver(path: "auth/facebook-signin"), body: body);
    return _mapJsonToUser(response);
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
        await client.post(const URLResolver(path: "auth/register"), body: body);
    return _mapJsonToUser(response);
  }

  User _mapJsonToUser(dynamic jsonResponse) {
    dynamic userData = jsonResponse["data"];
    return User(
        id: userData["id"],
        name: userData["name"],
        email: userData["email"],
        emailVerifiedAt: DateTime.tryParse(userData["email_verified_at"] ?? ""),
        accessToken: jsonResponse["access_token"],
        tokenType: jsonResponse["token_type"]);
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
    client.removeInterceptor(AuthenticationInterceptor);
  }
}
