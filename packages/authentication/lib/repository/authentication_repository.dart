import 'package:network/network.dart';

abstract class AuthenticationRepository {
  Future<void> login({
    required String email,
    required String password,
  });
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  AuthenticationRepositoryImpl({required this.client});

  final HttpNetwork client;

  @override
  Future<void> login({required String email, required String password}) async {
    Map<String, dynamic> body = {"email": email, "password": password};
    await client.post(const URLResolver(path: "user/login"), body);
  }
}
