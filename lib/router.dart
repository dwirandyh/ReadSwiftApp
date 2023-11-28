import 'package:authentication/authentication.dart';
import 'package:go_router/go_router.dart';
import 'package:readswift_app/onboarding/onboard_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "Onboard",
      builder: (context, state) {
        return const OnboardPage();
      },
    ),
    ...AuthenticationRouter.routes,
  ],
);
