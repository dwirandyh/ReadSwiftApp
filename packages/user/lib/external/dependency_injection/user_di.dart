import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:user/bloc/change_password/change_password_bloc.dart';

import '../../repository/user_repository.dart';

class UserDI {
  static void setup() {
    GetIt.I.registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        client: HttpNetwork.client,
      ),
    );

    GetIt.I.registerFactory<ChangePasswordBloc>(
      () => ChangePasswordBloc(
        userRepository: GetIt.I.get(),
      ),
    );
  }
}
