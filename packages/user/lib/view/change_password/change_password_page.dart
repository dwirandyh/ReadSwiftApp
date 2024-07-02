import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uikit/uikit.dart';

import '../../bloc/change_password/change_password_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage._({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) {
        return GetIt.I<ChangePasswordBloc>();
      },
      child: const ChangePasswordPage._(),
    );
  }

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordTextController =
      TextEditingController(text: null);
  final TextEditingController _newPasswordTextController =
      TextEditingController(text: null);
  final TextEditingController _confirmPasswordTextController =
      TextEditingController(text: null);

  void _saveChanges() {
    final currentPassword = _currentPasswordTextController.text;
    final newPassword = _newPasswordTextController.text;
    final confirmPassword = _confirmPasswordTextController.text;

    if (newPassword != confirmPassword) {
      UIToast.showToast(
        context: context,
        message: "New password and confirm password should be same",
        type: ToastType.error,
      );
      return;
    }

    context.read<ChangePasswordBloc>().add(
          ChangePasswordRequested(
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword,
          ),
        );
  }

  void _onChangePasswordError(ChangePasswordError state) {
    UIToast.showToast(
      context: context,
      message: state.message,
      type: ToastType.error,
    );
  }

  void _onChangePasswordSuccess(ChangePasswordSuccess state) {
    UIToast.showToast(
      context: context,
      message: "Password changed successfully",
      type: ToastType.info,
    );
  }

  @override
  void dispose() {
    _currentPasswordTextController.dispose();
    _newPasswordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change your password",
          style: appBarTextStyle(),
        ),
      ),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
            _onChangePasswordError(state);
          } else if (state is ChangePasswordSuccess) {
            _onChangePasswordSuccess(state);
          }
        },
        child: _bodyWidget(),
      ),
    );
  }

  Widget _bodyWidget() {
    final color = context.theme.uikit;
    return SafeArea(
      child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          return UILoading(
            isLoading: state is ChangePasswordLoading,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                autovalidateMode: null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Secure your account by updating your password",
                      style: TextStyle(fontSize: 14, color: color.subtitle),
                    ),
                    const SizedBox(height: 24),
                    UIKitTextField(
                      title: "Old Password",
                      placeholder: "Enter your old password",
                      rules: const [ValidationRule.required],
                      controller: _currentPasswordTextController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    UIKitTextField(
                      title: "New Password",
                      placeholder: "Enter your new password",
                      rules: const [ValidationRule.required],
                      controller: _newPasswordTextController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    UIKitTextField(
                      title: "Confirm Password",
                      placeholder: "Enter your confirm password",
                      rules: const [ValidationRule.required],
                      validator: (value) {
                        if (value != _newPasswordTextController.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                      controller: _confirmPasswordTextController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    UIKitButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveChanges();
                        }
                      },
                      text: "Save Changes",
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
