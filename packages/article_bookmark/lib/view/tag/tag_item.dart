import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class TagItem extends StatelessWidget {
  final String tag;
  final bool isActive;
  final GestureTapCallback onTap;
  const TagItem({
    super.key,
    required this.tag,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? color.accent : color.subtitle,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
