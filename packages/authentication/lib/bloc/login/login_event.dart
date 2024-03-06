part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

final class LoginRequested extends LoginEvent {
  const LoginRequested({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [];
}

final class LoginWithGoogleRequested extends LoginEvent {
  @override
  List<Object?> get props => [];
}

final class LoginWithFacebookRequested extends LoginEvent {
  @override
  List<Object?> get props => [];
}