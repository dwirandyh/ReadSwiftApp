import 'package:flutter/material.dart';

enum UIKitButtonType { elevated, outlined }

class UIKitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final UIKitButtonType type;
  final Image? icon;
  final bool isEnabled;
  const UIKitButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = UIKitButtonType.elevated,
    this.icon,
    this.isEnabled = true,
  });

  Widget _elevatedButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }

  Widget _outlinedButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            if (icon != null) icon!,
            Expanded(
              child: Center(
                child: Text(text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case UIKitButtonType.elevated:
        return _elevatedButton(context);
      case UIKitButtonType.outlined:
        return _outlinedButton(context);
    }
  }
}
