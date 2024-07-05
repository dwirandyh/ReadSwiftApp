import 'package:flutter/material.dart';
import 'package:uikit/theme/theme_manager/theme_provider.dart';

extension BrightnessExtension on BuildContext {
  bool get isPlatformDarkMode {
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(this);
    return platformBrightness == Brightness.dark;
  }

  bool get isPlatformLightMode {
    final Brightness platformBrightness = MediaQuery.platformBrightnessOf(this);
    return platformBrightness == Brightness.light;
  }

  ThemeModePreference get platformThemeModePreference {
    return isPlatformDarkMode
        ? ThemeModePreference.dark
        : ThemeModePreference.light;
  }
}
