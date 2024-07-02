import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

enum UIKitButtonType { elevated, outlined, text }

enum UIKitButtonStyle { primary, secondary, danger }

class UIKitButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final UIKitButtonType type;
  final UIKitButtonStyle style;
  final Image? icon;
  final bool isEnabled;
  final bool isLoading;
  const UIKitButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = UIKitButtonType.elevated,
    this.style = UIKitButtonStyle.primary,
    this.icon,
    this.isEnabled = true,
    this.isLoading = false,
  });

  Color textColor(BuildContext context) {
    switch (style) {
      case UIKitButtonStyle.primary:
        return const Color(0xFFFFFFFF);
      case UIKitButtonStyle.secondary:
        return const Color(0xFF656A6F);
      case UIKitButtonStyle.danger:
        return const Color(0xFFFFFFFF);
    }
  }

  Color backgroundColor(BuildContext context) {
    final color = context.theme.uikit;
    switch (style) {
      case UIKitButtonStyle.primary:
        return color.accent;
      case UIKitButtonStyle.secondary:
        return Color(0xFFE0E0E1);
      case UIKitButtonStyle.danger:
        return color.danger;
    }
  }

  Widget _elevatedButton(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          backgroundColor: backgroundColor(context),
        ),
        child: Row(
          children: [
            if (icon != null) icon!,
            Expanded(
              child: _buttonText(context,
                  textStyle: TextStyle(color: textColor(context))),
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
              child: _buttonText(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonText(BuildContext context, {TextStyle? textStyle = null}) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ).merge(textStyle),
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
