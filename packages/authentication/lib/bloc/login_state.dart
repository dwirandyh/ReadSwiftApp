part of 'login_bloc.dart';

enum LoginStatus { idle, error, loading, success, failed }

class LoginState extends Equatable {
  const LoginState(this.status, this.message);

  final LoginStatus status;
  final String message;

  LoginState copyWith({
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      status ?? this.status,
      message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, message];
}
