import 'package:flutter/material.dart';
import 'package:readswift_app/main_page.dart';
import 'package:uikit/theme/uikit_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          UIKitThemeColor.light,
        ],
      ),
      darkTheme:
          ThemeData.dark().copyWith(extensions: <ThemeExtension<dynamic>>[
        UIKitThemeColor.dark,
      ]),
      themeMode: ThemeMode.light,
      home: MainPage(),
    );
  }
}
