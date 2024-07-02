import 'package:authentication/repository/authentication_repository.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc extends AuthenticationBlocAPI {
  final AuthenticationRepository repository;

  AuthenticationBloc({required this.repository})
      : super(AuthenticationState.unauthenticated()) {
    on<AuthenticationStatusRequested>(_onAuthenticationStatusRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  Future<void> _onAuthenticationStatusRequested(
      AuthenticationStatusRequested event,
      Emitter<AuthenticationState> emit) async {
    if (isClosed) {
      return;
    }

    final User? user = await repository.getAuthenticatedUser();
    if (user != null) {
      emit(AuthenticationState.authenticated(user));
    } else {
      emit(AuthenticationState.unauthenticated());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
      AuthenticationLogoutRequested event,
      Emitter<AuthenticationState> emit) async {
    await repository.logout();
    emit(AuthenticationState.unauthenticated());
  }
}
