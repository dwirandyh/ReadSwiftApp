import 'package:authentication/bloc/login_bloc.dart';
import 'package:authentication/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';
import 'package:uikit/uikit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Widget _loginForm(BuildContext context) {
    final color = context.theme.uikit;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIKitTextField(
            title: "Email address",
            placeholder: "Type your email here",
            rules: const [
              ValidationRule.email,
              ValidationRule.isEmtpy,
            ],
            fieldName: "Email",
            controller: emailTextController,
          ),
          const SizedBox(height: 16),
          UIKitTextField(
            title: "Password",
            placeholder: "Type your password here",
            rules: const [
              ValidationRule.isEmtpy,
            ],
            fieldName: "Password",
            controller: passwordTextController,
            obscureText: true,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                fontSize: 14,
                color: color.subtitle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: UIKitButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginRequested(
                        email: emailTextController.text,
                        password: passwordTextController.text,
                      ));
                }
              },
              text: "Log In",
            ),
          ),
        ],
      ),
    );
  }

  Widget _signInAlternative(BuildContext context) {
    final theme = context.theme.uikit;
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "OR",
                style: TextStyle(
                  color: theme.subtitle,
                ),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: UIKitButton(
                onPressed: () {},
                text: "Google",
                type: UIKitButtonType.outlined,
                icon: Image.asset(
                  "assets/ic_google.png",
                  package: "authentication",
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: UIKitButton(
                onPressed: () {},
                text: "Facebook",
                type: UIKitButtonType.outlined,
                icon: Image.asset(
                  "assets/ic_facebook.png",
                  package: "authentication",
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  AuthenticationRepositoryImpl(client: HttpNetwork.client()),
            );
          },
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
                    UIToast.showToast(
                      context: context,
                      message: state.message,
                      type: ToastType.info,
                    );
                  }
                },
                child: UILoading(
                  isLoading: state.status == LoginStatus.loading ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log In to Your Account",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: color.title,
                          ),
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
                        _loginForm(context),
                        const SizedBox(height: 16),
                        _signInAlternative(context),
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
      ),
    );
  }
}
