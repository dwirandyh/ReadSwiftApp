import 'package:authentication/authentication.dart';
import 'package:authentication/bloc/register/register_bloc.dart';
import 'package:authentication/repository/authentication_repository.dart';
import 'package:authentication/view/register/register_form.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:network/network.dart';
import 'package:storage/secure_storage.dart';
import 'package:uikit/uikit.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) {
        return RegisterBloc(
          authenticationRepository: AuthenticationRepositoryImpl(
            client: HttpNetwork.client(),
            secureStorageService: SecureStorageService.instance(),
          ),
        );
      },
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            UIToast.showToast(
              context: context,
              message: state.message,
              type: ToastType.error,
            );
          } else if (state is RegisterSuccess) {
            context
                .read<AuthenticationBlocAPI>()
                .add(AuthenticationStatusRequested());
          }
        },
        child: const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return UILoading(
              isLoading: state is RegisterLoading,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Register Account",
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
                            "You can create the account with input your name, email address, and password",
                            style: TextStyle(
                              fontSize: 14,
                              color: color.subtitle,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const RegisterForm(),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "You already have an account? ",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.push(AuthenticationRouter.loginPage);
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
