import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class MessageDisplayWidget extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Widget? actionWidget;

  const MessageDisplayWidget({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;

    return Center(
      child: Column(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            title,
            style: TextStyle(fontSize: 18, color: color.title),
            textAlign: TextAlign
                .center, // Center align the text for better readability
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle!,
              style: TextStyle(fontSize: 16, color: color.subtitle),
              textAlign: TextAlign.center,
            ),
          ],
          if (actionWidget != null) ...[
            const SizedBox(height: 16),
            actionWidget!,
          ],
        ],
      ),
    );
  }
}
