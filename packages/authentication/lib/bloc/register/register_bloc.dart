import 'package:authentication/repository/authentication_repository.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationRepository authenticationRepository;

  RegisterBloc({
    required this.authenticationRepository,
  }) : super(RegisterInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterLoading());
      User user = await authenticationRepository.register(
          name: event.name, email: event.email, password: event.password);
      await authenticationRepository.saveAuthenticatedUser(user: user);
      emit(RegisterSuccess());
    } catch (error) {
      String message = "Failed to register, please try again later";
      if (error is NetworkException) {
        if (error.statusCode == 409) {
          message = "User with the email already exists";
        }
      }
      emit(RegisterError(message: message));
    }
  }
}
