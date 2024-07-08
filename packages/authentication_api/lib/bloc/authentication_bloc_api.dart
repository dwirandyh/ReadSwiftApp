import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

abstract class AuthenticationBlocAPI
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBlocAPI(super.initialState);
}
