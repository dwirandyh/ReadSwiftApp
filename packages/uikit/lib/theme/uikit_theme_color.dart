import 'package:flutter/material.dart';
import 'package:uikit/theme/component/pre_theme.dart';

class UIKitThemeColor extends ThemeExtension<UIKitThemeColor> {
  final Color background;
  final Color title;
  final Color subtitle;
  final Color caption;
  final Color body;
  final Color border;
  final Color accent;
  final Color softAccent;
  final Color danger;
  final Color divider;
  final PreTheme preTheme;

  const UIKitThemeColor({
    required this.background,
    required this.title,
    required this.subtitle,
    required this.caption,
    required this.body,
    required this.border,
    required this.accent,
    required this.softAccent,
    required this.danger,
    required this.divider,
    required this.preTheme,
  });

  @override
  UIKitThemeColor copyWith({
    Color? background,
    Color? title,
    Color? subtitle,
    Color? caption,
    Color? body,
    Color? border,
    ButtonTheme? button,
    Color? accent,
    Color? softAccent,
    Color? danger,
    Color? divider,
    PreTheme? preTheme,
  }) {
    return UIKitThemeColor(
      background: background ?? this.background,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      caption: caption ?? this.caption,
      body: body ?? this.body,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      softAccent: softAccent ?? this.softAccent,
      danger: danger ?? this.danger,
      preTheme: preTheme ?? this.preTheme,
      divider: divider ?? this.divider,
    );
  }

  @override
  UIKitThemeColor lerp(
      covariant ThemeExtension<UIKitThemeColor> other, double t) {
    if (other is! UIKitThemeColor) {
      return this;
    }
    return UIKitThemeColor(
      background: background,
      title: title,
      subtitle: subtitle,
      caption: caption,
      body: body,
      border: border,
      accent: accent,
      softAccent: softAccent,
      danger: danger,
      preTheme: preTheme,
      divider: divider,
    );
  }

  static const light = UIKitThemeColor(
    background: Color.fromRGBO(255, 255, 255, 255),
    title: Color.fromRGBO(36, 36, 36, 1),
    subtitle: Color.fromRGBO(77, 77, 77, 1),
    caption: Color.fromRGBO(153, 153, 153, 1),
    body: Color.fromRGBO(36, 36, 36, 1),
    border: Color.fromRGBO(153, 153, 153, 1),
    accent: Color.fromRGBO(34, 177, 169, 1.0),
    softAccent: Color.fromRGBO(121, 150, 148, 1.0),
    danger: Color.fromRGBO(241, 96, 99, 1.0),
    divider: Color.fromRGBO(218, 218, 218, 1.0),
    preTheme: PreTheme(
      background: Color.fromRGBO(249, 249, 249, 1),
      borderColor: Color.fromRGBO(229, 229, 229, 1),
    ),
  );

  static const dark = UIKitThemeColor(
    background: Color.fromRGBO(0, 0, 0, 1),
    title: Color.fromRGBO(255, 255, 255, 1),
    subtitle: Color.fromRGBO(204, 204, 204, 1),
    caption: Color.fromRGBO(153, 153, 153, 1),
    body: Color.fromRGBO(238, 238, 238, 1.0),
    border: Color.fromRGBO(102, 102, 102, 1),
    accent: Color.fromRGBO(34, 177, 169, 1.0),
    softAccent: Color.fromRGBO(106, 131, 129, 1.0),
    danger: Color.fromRGBO(241, 96, 99, 1.0),
    divider: Color.fromRGBO(218, 218, 218, 1.0),
    preTheme: PreTheme(
      background: Color.fromRGBO(249, 249, 249, 1),
      borderColor: Color.fromRGBO(229, 229, 229, 1),
    ),
  );
}
