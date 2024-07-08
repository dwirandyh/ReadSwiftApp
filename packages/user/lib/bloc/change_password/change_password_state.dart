part of 'change_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangePasswordError extends ChangePasswordState {
  final String message;

  ChangePasswordError({required this.message});

  @override
  List<Object?> get props => [message];
}
