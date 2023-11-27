part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class LoginRequested extends LoginEvent {
  const LoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
