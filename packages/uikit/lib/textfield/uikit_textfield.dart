import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class UIKitTextField extends StatelessWidget {
  final String title;
  final String placeholder;

  const UIKitTextField(
      {super.key, required this.title, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: color.caption,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: color.border),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color.border),
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: placeholder,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(14, 14, 14, 14),
          ),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
