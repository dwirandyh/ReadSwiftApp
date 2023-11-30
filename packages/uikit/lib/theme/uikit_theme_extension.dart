import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

extension UIKitThemeExtension on ThemeData {
  UIKitThemeColor get uikit =>
      extension<UIKitThemeColor>() ?? UIKitThemeColor.light;
}

extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
}
