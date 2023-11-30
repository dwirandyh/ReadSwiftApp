part of 'authentication_bloc_api.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User? user;

  const AuthenticationState._({required this.status, this.user});

  factory AuthenticationState.authenticated(User user) {
    return AuthenticationState._(
        status: AuthenticationStatus.authenticated, user: user);
  }

  factory AuthenticationState.unauthenticated() {
    return const AuthenticationState._(
        status: AuthenticationStatus.unauthenticated);
  }

  @override
  List<Object?> get props => [status, user];
}
