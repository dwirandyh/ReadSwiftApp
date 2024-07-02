import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

import '../../bloc/delete_account/delete_account_bloc.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage._({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => GetIt.I.get<DeleteAccountBloc>(),
      child: const DeleteAccountPage._(),
    );
  }

  void _onDeleteTapped(BuildContext context) {
    context.read<DeleteAccountBloc>().add(DeleteAccountRequested());
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
      builder: (context, state) {
        return BlocListener<DeleteAccountBloc, DeleteAccountState>(
          listener: (context, state) {
            if (state is DeleteAccountSuccess) {
              context
                  .read<AuthenticationBlocAPI>()
                  .add(AuthenticationLogoutRequested());
            } else if (state is DeleteAccountFailure) {
              UIToast.showToast(
                context: context,
                message: state.message,
                type: ToastType.error,
              );
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.account_circle_outlined,
                        size: 84,
                        color: color.caption,
                      ),
                      Positioned(
                        right: 2,
                        bottom: -1,
                        child: Icon(
                          Icons.warning_sharp,
                          color: color.danger,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      "Delete your account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: color.title,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "You will lose all of your data by deleting your account. This action cannot be undone.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: color.subtitle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  UIKitButton(
                    onPressed: () {
                      _onDeleteTapped(context);
                    },
                    text: "Delete Account",
                    style: UIKitButtonStyle.danger,
                  ),
                  const SizedBox(height: 8),
                  UIKitButton(
                    onPressed: () {
                      context.pop();
                    },
                    text: "Cancel",
                    style: UIKitButtonStyle.secondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
