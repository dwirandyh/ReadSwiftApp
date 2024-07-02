import 'package:flutter/material.dart';
import 'package:uikit/textfield/validation_helper.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

enum ValidationRule { required, email, url }

class UIKitTextField extends StatelessWidget {
  final String? title;
  final String? placeholder;
  final List<ValidationRule> rules;
  final String? fieldName;
  final TextEditingController? controller;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

  const UIKitTextField({
    super.key,
    this.title,
    this.placeholder,
    this.rules = const [],
    this.fieldName,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  String? _validate(String? value) {
    for (var rule in rules) {
      switch (rule) {
        case ValidationRule.required:
          String? isEmptyError = ValidationHelper.validateIsEmpty(
            value ?? "",
            fieldName ?? title ?? "",
          );
          if (isEmptyError != null) {
            return isEmptyError;
          }
          break;
        case ValidationRule.email:
          String? emailError = ValidationHelper.validateEmail(value ?? "");
          if (emailError != null) {
            return emailError;
          }
          break;
        case ValidationRule.url:
          String? urlError = ValidationHelper.validateUrl(value ?? "");
          if (urlError != null) {
            return urlError;
          }
          break;
      }
    }

    if (validator != null) {
      return validator!(value);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: color.caption,
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          validator: _validate,
          autovalidateMode: autovalidateMode,
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
            contentPadding: const EdgeInsets.fromLTRB(0, 14, 14, 14),
            prefix: const Padding(
              padding: EdgeInsets.only(left: 14.0),
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
