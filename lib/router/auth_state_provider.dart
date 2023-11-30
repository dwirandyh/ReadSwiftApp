import 'dart:async';

import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';

class AuthStateProvider extends ChangeNotifier {
  late final StreamSubscription<AuthenticationState> _blocStream;
  AuthStateProvider(AuthenticationBlocAPI bloc) {
    _blocStream = bloc.stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _blocStream.cancel();
    super.dispose();
  }
}
