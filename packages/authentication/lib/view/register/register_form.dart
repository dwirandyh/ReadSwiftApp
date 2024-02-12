import 'package:authentication/bloc/register/register_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIKitTextField(
            title: "Name",
            placeholder: "Type your name here",
            rules: const [
              ValidationRule.required,
            ],
            controller: _nameTextController,
            fieldName: "Name",
          ),
          const SizedBox(height: 16),
          UIKitTextField(
            title: "Email",
            placeholder: "Type your email here",
            rules: const [
              ValidationRule.required,
              ValidationRule.email,
            ],
            fieldName: "Email",
            controller: _emailTextController,
          ),
          const SizedBox(height: 16),
          UIKitTextField(
            title: "Password",
            placeholder: "Type your password here",
            rules: const [
              ValidationRule.required,
            ],
            obscureText: true,
            controller: _passwordTextController,
          ),
          const SizedBox(height: 16),
          UIKitTextField(
            title: "Confirm Password",
            placeholder: "Confirm your password",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please confirm your password";
              }
              if (value != _passwordTextController.text) {
                return "Your confirmation password is incorrect";
              }
              return null;
            },
            obscureText: true,
            controller: _confirmPasswordTextController,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: UIKitButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<RegisterBloc>().add(
                        RegisterRequested(
                          name: _nameTextController.text,
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                        ),
                      );
                }
              },
              text: "Register Now",
            ),
          ),
        ],
      ),
    );
  }
}
