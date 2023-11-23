import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class UIKitTheme {
  static final light = ThemeData.light().copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(34, 177, 169, 1.0),
        elevation: 0,
        shadowColor: Colors.transparent,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Color.fromRGBO(98, 97, 97, 1.0),
        side: BorderSide(
          width: 1,
          color: Color.fromRGBO(98, 97, 97, 1.0),
        ),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      UIKitThemeColor.light,
    ],
  );

  static final dark = ThemeData.dark().copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(34, 177, 169, 1.0),
        elevation: 0,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Color.fromRGBO(194, 194, 194, 1.0),
        side: BorderSide(
          width: 1,
          color: Color.fromRGBO(194, 194, 194, 1.0),
        ),
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[
      UIKitThemeColor.dark,
    ],
  );
}
