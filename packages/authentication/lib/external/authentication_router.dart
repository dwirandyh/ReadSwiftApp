import 'package:authentication/authentication.dart';
import 'package:go_router/go_router.dart';

class AuthenticationRouter {
  static List<RouteBase> routes = [
    GoRoute(
      path: "/authentication/login",
      name: "LoginPage",
      builder: (context, state) {
        return LoginPage.create();
      },
    ),
    GoRoute(
      path: "/authentication/register",
      name: "RegisterPage",
      builder: (context, state) {
        return RegisterPage.create();
      },
    )
  ];
}
