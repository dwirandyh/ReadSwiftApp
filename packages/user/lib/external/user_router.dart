import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user/view/change_password/change_password_page.dart';
import 'package:user/view/manage_tag/manage_tag_page.dart';

import '../view/delete_account/delete_account_page.dart';

class UserRouter {
  UserRouter._();

  static const String changePassword = "/user/change-password";
  static const String manageTag = "/user/manage-tag";

  static void goToChangePassword(BuildContext context) {
    context.push(
      changePassword,
    );
  }

  static void goToManageTag(BuildContext context) {
    context.push(
      manageTag,
    );
  }

  static void goToDeleteAccount(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DeleteAccountPage.create();
      },
    );
  }

  static List<RouteBase> routes = [
    GoRoute(
      path: changePassword,
      builder: (context, state) {
        return ChangePasswordPage.create();
      },
    ),
    GoRoute(
      path: manageTag,
      builder: (context, state) {
        return ManageTagPage.create();
      },
    )
  ];
}
