import 'package:flutter/material.dart';
import 'package:uikit/theme/theme_manager/theme_provider.dart';
import 'package:uikit/theme/uikit_theme.dart';

class ThemeManager extends StatefulWidget {
  final ThemeModePreference themeModePreference;
  final Widget child;
  const ThemeManager(
      {super.key, required this.child, required this.themeModePreference});

  @override
  State<ThemeManager> createState() => _ThemeManagerState();
}

class _ThemeManagerState extends State<ThemeManager> {
  ThemeData? _themeData;

  @override
  void initState() {
    super.initState();
  }

  void _updateTheme(ThemeModePreference preference) {
    switch (preference) {
      case ThemeModePreference.light:
        setState(() {
          _themeData = _getThemeData(preference);
        });
      case ThemeModePreference.dark:
        setState(() {
          _themeData = _getThemeData(preference);
        });
      case ThemeModePreference.system:
        setState(() {
          _themeData = _getThemeData(preference);
        });
    }
  }

  ThemeData _getThemeData(ThemeModePreference preference) {
    switch (preference) {
      case ThemeModePreference.light:
        return UIKitTheme.light;
      case ThemeModePreference.dark:
        return UIKitTheme.dark;
      case ThemeModePreference.system:
        Brightness platformBrightness =
            MediaQuery.platformBrightnessOf(context);
        return platformBrightness == Brightness.dark
            ? UIKitTheme.dark
            : UIKitTheme.light;
    }
  }

  @override
  void didUpdateWidget(ThemeManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.themeModePreference != widget.themeModePreference) {
      _updateTheme(widget.themeModePreference);
    }
  }

  @override
  Widget build(BuildContext context) {
    _themeData ??= _getThemeData(widget.themeModePreference);
    return ThemeProvider(
      themeData: _themeData ?? UIKitTheme.light,
      updateTheme: _updateTheme,
      child: widget.child,
    );
  }
}
