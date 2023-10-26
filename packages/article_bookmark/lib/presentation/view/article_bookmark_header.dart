import 'package:flutter/material.dart';

class ArticleBookmarkHeader extends StatelessWidget {
  const ArticleBookmarkHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Home",
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 26,
        color: Color.fromRGBO(0, 0, 0, 1),
      ),
    );
  }
}
