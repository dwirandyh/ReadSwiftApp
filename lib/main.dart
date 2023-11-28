import 'package:flutter/material.dart';
import 'package:readswift_app/router.dart';
import 'package:uikit/theme/uikit_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: UIKitTheme.light,
      darkTheme: UIKitTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
