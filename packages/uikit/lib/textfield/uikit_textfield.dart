import 'package:flutter/material.dart';
import 'package:uikit/textfield/validation_helper.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

enum ValidationRule { isEmtpy, email }

class UIKitTextField extends StatelessWidget {
  final String title;
  final String placeholder;
  final List<ValidationRule> rules;
  final String fieldName;
  final TextEditingController? controller;
  final bool obscureText;

  const UIKitTextField({
    super.key,
    required this.title,
    required this.placeholder,
    this.rules = const [],
    this.fieldName = "Field",
    this.controller,
    this.obscureText = false,
  });

  String? _validate(String? value) {
    for (var rule in rules) {
      switch (rule) {
        case ValidationRule.email:
          return ValidationHelper.validateEmail(value ?? "");
        case ValidationRule.isEmtpy:
          return ValidationHelper.validateIsEmpty(value ?? "", fieldName);
      }
    }
    return null;
  }

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
        const SizedBox(height: 8),
        TextFormField(
          validator: _validate,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          controller: controller,
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
            contentPadding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
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
