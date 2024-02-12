import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:readswift_app/di/dependency_composition.dart';
import 'package:readswift_app/router/router.dart';
import 'package:uikit/theme/uikit_theme.dart';

void main() {
  DependencyComposition.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I.get<AuthenticationBlocAPI>()
        ..add(AuthenticationStatusRequested()),
      child: MaterialApp.router(
        title: 'ReadSwift',
        theme: UIKitTheme.light,
        darkTheme: UIKitTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      ),
    );
  }
}
