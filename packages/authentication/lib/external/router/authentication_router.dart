import 'package:authentication/authentication.dart';
import 'package:go_router/go_router.dart';

class AuthenticationRouter {
  AuthenticationRouter._();

  static const String loginPage = "/authentication/login";
  static const String registerPage = "/authentication/register";

  static List<RouteBase> routes = [
    GoRoute(
      path: AuthenticationRouter.loginPage,
      builder: (context, state) {
        return LoginPage.create();
      },
    ),
    GoRoute(
      path: AuthenticationRouter.registerPage,
      builder: (context, state) {
        return RegisterPage.create();
      },
    )
  ];
}
