import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ReorderableProxyDecorator extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const ReorderableProxyDecorator({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Material(
          color: color.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: UIKitThemeColor.dark.accent),
                borderRadius: BorderRadius.circular(4),
              ),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
