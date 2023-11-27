import 'package:authentication/model/user.dart';
import 'package:authentication/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authenticationRepository,
  }) : super(const LoginState(LoginStatus.initial, "")) {
    on<LoginRequested>(_onLoginRequested);
  }

  final AuthenticationRepository authenticationRepository;

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      User user = await authenticationRepository.login(
          email: event.email, password: event.password);
      await authenticationRepository.saveAuthenticatedUser(user: user);
      emit(state.copyWith(
        status: LoginStatus.success,
        message: "Login Success, navigate to home later",
      ));
    } catch (error) {
      String errorMessage = "Failed to login, please try again later";
      if (error is NetworkException) {
        if (error.statusCode == 404) {
          errorMessage =
              "Uh-oh! We couldn't find that user. Please check your details and try again or sign up if you're new.";
        }
      }

      emit(state.copyWith(
        status: LoginStatus.error,
        message: errorMessage,
      ));
    }
  }
}
