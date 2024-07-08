import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repository/user_repository.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final UserRepository userRepository;

  DeleteAccountBloc({required this.userRepository})
      : super(DeleteAccountInitial()) {
    on<DeleteAccountRequested>(_onDeleteAccountRequested);
  }

  Future<void> _onDeleteAccountRequested(
    DeleteAccountRequested event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoading());
    try {
      // await userRepository.deleteAccount();
      await Future.delayed(Duration(seconds: 2));
      emit(DeleteAccountSuccess());
    } catch (error) {
      String errorMessage = "Failed to delete account, please try again later";
      emit(DeleteAccountFailure(errorMessage));
    }
  }
}
