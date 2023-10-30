import 'package:flutter/material.dart';

class UIKitThemeColor extends ThemeExtension<UIKitThemeColor> {
  final Color background;
  final Color title;
  final Color caption;

  const UIKitThemeColor({
    required this.background,
    required this.title,
    required this.caption,
  });

  @override
  UIKitThemeColor copyWith({
    Color? black,
    Color? black80,
    Color? gray,
    Color? gray50,
  }) {
    return UIKitThemeColor(
      background: black ?? background,
      title: black80 ?? title,
      caption: gray ?? caption,
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
      caption: caption,
    );
  }

  static const light = UIKitThemeColor(
    background: Color.fromRGBO(255, 255, 255, 255),
    title: Color.fromRGBO(77, 77, 77, 1),
    caption: Color.fromRGBO(153, 153, 153, 1),
  );

  static const dark = UIKitThemeColor(
    background: Color.fromRGBO(0, 0, 0, 1),
    title: Color.fromRGBO(255, 255, 255, 1),
    caption: Color.fromRGBO(179, 179, 179, 1),
  );
}
