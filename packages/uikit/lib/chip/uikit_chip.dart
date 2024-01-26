import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class UIChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final GestureTapCallback onTap;

  const UIChip(
      {super.key,
      required this.text,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? color.accent : color.subtitle,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
    return const Placeholder();
  }
}
