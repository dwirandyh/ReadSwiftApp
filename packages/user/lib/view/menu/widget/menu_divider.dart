import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';

class MenuDivider extends StatelessWidget {
  const MenuDivider({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Container(
      width: double.infinity,
      height: 6,
      color: color.divider,
    );
  }
}
