import 'package:authentication/bloc/login/login_bloc.dart';
import 'package:authentication/repository/authentication_repository.dart';
import 'package:authentication/view/login/login_alternative_view.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:network/network.dart';
import 'package:storage/secure_storage_service.dart';
import 'package:uikit/uikit.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          authenticationRepository: AuthenticationRepositoryImpl(
            client: HttpNetwork.client,
            secureStorageService: SecureStorageService.instance(),
          ),
        );
      },
      child: const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.status == LoginStatus.error) {
                  UIToast.showToast(
                    context: context,
                    message: state.message,
                    type: ToastType.error,
                  );
                } else if (state.status == LoginStatus.success) {
                  context
                      .read<AuthenticationBlocAPI>()
                      .add(AuthenticationStatusRequested());
                }
              },
              child: UILoading(
                isLoading: state.status == LoginStatus.loading ? true : false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Log In to Your Account",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: color.title,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                context.pop();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 28),
                      Text(
                        "Please enter your email and password to access your account",
                        style: TextStyle(
                          fontSize: 14,
                          color: color.subtitle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const LoginForm(),
                      const SizedBox(height: 16),
                      const LoginAlternativeView(),
                      const Spacer(),
                      const Text(
                        "By signin up, you agree to our Term of Service and acknoledge that our Privacy Policy applies to you.",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
