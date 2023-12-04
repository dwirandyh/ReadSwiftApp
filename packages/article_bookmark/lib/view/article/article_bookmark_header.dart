import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class ArticleBookmarkHeader extends StatelessWidget {
  const ArticleBookmarkHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Row(
      children: [
        Text(
          "ReadSwift",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
            color: color.title,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        )
      ],
    );
  }
}
