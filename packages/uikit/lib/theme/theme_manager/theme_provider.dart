import 'package:flutter/material.dart';

enum ThemeModePreference {
  light('light'),
  dark('dark'),
  system('system');

  final String key;
  const ThemeModePreference(this.key);
}

@immutable
class ThemeProvider extends InheritedWidget {
  ThemeData themeData;
  final Function(ThemeModePreference) updateTheme;

  ThemeProvider({
    super.key,
    required this.themeData,
    required this.updateTheme,
    required Widget child,
  }) : super(child: child);

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return themeData != oldWidget.themeData;
  }
}
