import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';

class RssHeaderView extends StatelessWidget {
  const RssHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Row(
      children: [
        Text(
          "RSS",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: color.title,
          ),
        )
      ],
    );
  }
}
