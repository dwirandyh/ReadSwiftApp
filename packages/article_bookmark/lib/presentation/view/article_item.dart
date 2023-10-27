import 'package:article_bookmark/domain/entity/article_entity.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme.dart';

class ArticleItem extends StatelessWidget {
  final ArticleEntity article;

  const ArticleItem({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color.title,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  article.excerpt ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: color.title,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    Text("Aug 20"),
                    Text("•"),
                    Text("5 Mins"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
