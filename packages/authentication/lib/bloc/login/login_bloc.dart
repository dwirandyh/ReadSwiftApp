import 'package:authentication/repository/authentication_repository.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:network/network.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;

  LoginBloc({
    required this.authenticationRepository,
  }) : super(const LoginState(LoginStatus.initial, "")) {
    on<LoginRequested>(_onLoginRequested);
    on<LoginWithGoogleRequested>(_onLoginWithGoogleRequested);
  }

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

  Future<void> _onLoginWithGoogleRequested(
    LoginWithGoogleRequested event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final String? token = googleSignInAuthentication.accessToken;
        await googleSignIn.signOut();

        if (token != null) {
          User user = await authenticationRepository.loginWithGoogle(
              accessToken: token);
          await authenticationRepository.saveAuthenticatedUser(user: user);
          emit(state.copyWith(
            status: LoginStatus.success,
            message: "Login Success, navigate to home later",
          ));
        }
      } else {
        emit(state.copyWith(
          status: LoginStatus.error,
          message: "Failed to open google sign in form, try again later",
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        status: LoginStatus.error,
        message: "Failed to login, please check your account and try again",
      ));
    }
  }
}
