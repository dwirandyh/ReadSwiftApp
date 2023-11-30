part of 'authentication_bloc_api.dart';

enum AuthenticationStatus { authenticated, unauthenticated }

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AuthenticationStatusRequested extends AuthenticationEvent {}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}
