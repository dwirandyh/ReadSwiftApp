import 'package:flutter/material.dart';
import 'package:uikit/button/uikit_button.dart';
import 'package:uikit/theme/uikit_theme_extension.dart';

class LoginAlternativeView extends StatelessWidget {
  const LoginAlternativeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.uikit;
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "OR",
                style: TextStyle(
                  color: theme.subtitle,
                ),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: UIKitButton(
                onPressed: () {},
                text: "Google",
                type: UIKitButtonType.outlined,
                icon: Image.asset(
                  "assets/ic_google.png",
                  package: "authentication",
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: UIKitButton(
                onPressed: () {},
                text: "Facebook",
                type: UIKitButtonType.outlined,
                icon: Image.asset(
                  "assets/ic_facebook.png",
                  package: "authentication",
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
