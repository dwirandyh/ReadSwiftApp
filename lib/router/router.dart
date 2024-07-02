import 'package:article_bookmark/external/ArticleBookmarkRouter.dart';
import 'package:authentication/authentication.dart';
import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:readswift_app/main_page.dart';
import 'package:readswift_app/onboarding/onboard_page.dart';
import 'package:rss/rss.dart';
import 'package:user/external/user_router.dart';

import 'auth_state_provider.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) {
        return const OnboardPage();
      },
    ),
    GoRoute(
      path: "/main",
      builder: (context, state) {
        return MainPage.create();
      },
    ),
    ...AuthenticationRouter.routes,
    ...ArticleBookmarkRouter.routes,
    ...RssRouter.routes,
    ...UserRouter.routes,
  ],
  redirect: (context, state) {
    final authStatus = context.read<AuthenticationBlocAPI>().state.status;

    final unprotectedPaths = {
      "/",
      "/onboard",
      "/authentication/register",
      "/authentication/login"
    };

    if (authStatus == AuthenticationStatus.unauthenticated) {
      if (unprotectedPaths.contains(state.fullPath)) {
        return state.fullPath == "/" ? "/onboard" : null;
      } else {
        return "/onboard";
      }
    }

    if (unprotectedPaths.contains(state.fullPath) &&
        authStatus == AuthenticationStatus.authenticated) {
      return "/main";
    }

    return null;
  },
  refreshListenable: AuthStateProvider(
    GetIt.I.get<AuthenticationBlocAPI>(),
  ),
);
