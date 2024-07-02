import 'package:network/network.dart';

abstract class UserRepository {
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
}

class UserRepositoryImpl extends UserRepository {
  final HttpNetwork client;

  UserRepositoryImpl({required this.client});

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    Map<String, dynamic> body = {
      "current_password": currentPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword,
    };
    await client.post(const URLResolver(path: "user/change-password"),
        body: body);
  }
}
