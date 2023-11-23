import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Widget _loginForm(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIKitTextField(
          title: "Email address",
          placeholder: "Type your email here",
        ),
        SizedBox(height: 16),
        UIKitTextField(
          title: "Password",
          placeholder: "Type your password here",
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot your password?",
            style: TextStyle(
              fontSize: 14,
              color: color.subtitle,
            ),
          ),
        ),
        SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: UIKitButton(onPressed: () {}, text: "Log In"),
        ),
      ],
    );
  }

  Widget _signInAlternative(BuildContext context) {
    final theme = context.theme.uikit;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
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
            Expanded(
              child: Divider(),
            ),
          ],
        ),
        SizedBox(
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
            SizedBox(width: 16),
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

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log In to Your Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: color.title,
                ),
              ),
              SizedBox(height: 28),
              Text(
                "Please enter your email and password to access your account",
                style: TextStyle(
                  fontSize: 14,
                  color: color.subtitle,
                ),
              ),
              SizedBox(height: 16),
              _loginForm(context),
              SizedBox(height: 16),
              _signInAlternative(context),
              Spacer(),
              Text(
                "By signin up, you agree to our Term of Service and acknoledge that our Privacy Policy applies to you.",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
