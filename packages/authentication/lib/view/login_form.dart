import 'package:authentication/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/button/uikit_button.dart';
import 'package:uikit/textfield/uikit_textfield.dart';
import 'package:uikit/theme/uikit_theme_extension.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  context.read<LoginBloc>().add(
                        LoginRequested(
                          email: emailTextController.text,
                          password: passwordTextController.text,
                        ),
                      );
                }
              },
              text: "Log In",
            ),
          ),
        ],
      ),
    );
  }
}
