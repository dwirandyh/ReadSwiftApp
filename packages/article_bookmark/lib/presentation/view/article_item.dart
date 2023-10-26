import 'package:article_bookmark/domain/entity/article_entity.dart';
import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final ArticleEntity article;

  const ArticleItem({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(article.title),
            ],
          ),
        ),
      ],
    );
  }
}
