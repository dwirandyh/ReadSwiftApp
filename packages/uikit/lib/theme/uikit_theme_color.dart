import 'package:flutter/material.dart';

class UIKitThemeColor extends ThemeExtension<UIKitThemeColor> {
  final Color background;
  final Color title;
  final Color subtitle;
  final Color caption;
  final Color border;
  final Color accent;
  final Color softAccent;
  final Color danger;

  const UIKitThemeColor({
    required this.background,
    required this.title,
    required this.subtitle,
    required this.caption,
    required this.border,
    required this.accent,
    required this.softAccent,
    required this.danger,
  });

  @override
  UIKitThemeColor copyWith({
    Color? background,
    Color? title,
    Color? subtitle,
    Color? caption,
    Color? border,
    ButtonTheme? button,
    Color? accent,
    Color? softAccent,
    Color? danger,
  }) {
    return UIKitThemeColor(
      background: background ?? this.background,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      caption: caption ?? this.caption,
      border: border ?? this.border,
      accent: accent ?? this.accent,
      softAccent: softAccent ?? this.softAccent,
      danger: danger ?? this.danger,
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
        border: border,
        accent: accent,
        softAccent: softAccent,
        danger: danger);
  }

  static const light = UIKitThemeColor(
    background: Color.fromRGBO(255, 255, 255, 255),
    title: Color.fromRGBO(77, 77, 77, 1),
    subtitle: Color.fromRGBO(77, 77, 77, 1),
    caption: Color.fromRGBO(153, 153, 153, 1),
    border: Color.fromRGBO(153, 153, 153, 1),
    accent: Color.fromRGBO(34, 177, 169, 1.0),
    softAccent: Color.fromRGBO(121, 150, 148, 1.0),
    danger: Color.fromRGBO(241, 96, 99, 1.0),
  );

  static const dark = UIKitThemeColor(
    background: Color.fromRGBO(0, 0, 0, 1),
    title: Color.fromRGBO(255, 255, 255, 1),
    subtitle: Color.fromRGBO(204, 204, 204, 1),
    caption: Color.fromRGBO(153, 153, 153, 1),
    border: Color.fromRGBO(102, 102, 102, 1),
    accent: Color.fromRGBO(34, 177, 169, 1.0),
    softAccent: Color.fromRGBO(106, 131, 129, 1.0),
    danger: Color.fromRGBO(241, 96, 99, 1.0),
  );
}
