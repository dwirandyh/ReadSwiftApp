import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

enum UIKitButtonType { elevated, outlined, text }

class UIKitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final UIKitButtonType type;
  final Image? icon;
  final bool isEnabled;
  final bool isLoading;
  const UIKitButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = UIKitButtonType.elevated,
    this.icon,
    this.isEnabled = true,
    this.isLoading = false,
  });

  Widget _elevatedButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
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

  Widget _textButton(BuildContext context) {
    final color = context.theme.uikit;
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: color.accent,
          ),
        ),
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

  Widget _loadingView(BuildContext context) {
    final color = context.theme.uikit;
    return Container(
      decoration: BoxDecoration(
        color: color.accent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case UIKitButtonType.elevated:
        return SizedBox(
          height: 40,
          child: Stack(
            children: [
              _elevatedButton(context),
              if (isLoading) _loadingView(context),
            ],
          ),
        );
      case UIKitButtonType.outlined:
        return SizedBox(
          height: 40,
          child: Stack(
            children: [
              _outlinedButton(context),
              if (isLoading) _loadingView(context),
            ],
          ),
        );
      case UIKitButtonType.text:
        return SizedBox(
          height: 40,
          child: Stack(
            children: [
              _textButton(context),
              if (isLoading) _loadingView(context),
            ],
          ),
        );
    }
  }
}
