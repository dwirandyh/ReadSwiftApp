import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network/network.dart';

import '../../repository/user_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordBloc({required this.userRepository})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordRequested>(_onChangePasswordRequested);
  }

  Future<void> _onChangePasswordRequested(
    ChangePasswordRequested event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());
    try {
      await userRepository.changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(ChangePasswordSuccess(message: "Password changed successfully"));
    } catch (error) {
      String errorMessage = "Failed to change password, please try again later";
      if (error is NetworkException) {
        if (error.statusCode == 404) {
          errorMessage = "Current password is incorrect";
        }
      }

      emit(ChangePasswordError(message: errorMessage));
    }
  }
}
