import 'package:authentication/bloc/authentication/authentication_bloc.dart';
import 'package:authentication/repository/authentication_repository.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:storage/secure_storage_service.dart';

class AuthenticationDI {
  static void setup() {
    GetIt.I.registerSingleton<AuthenticationBlocAPI>(
      AuthenticationBloc(
        repository: AuthenticationRepositoryImpl(
          client: HttpNetwork.client,
          secureStorageService: SecureStorageService.instance(),
        ),
      ),
    );
  }
}
