import 'package:article_bookmark/model/article.dart';
import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';

class ArticleDetailHeaderView extends StatelessWidget {
  final Article article;
  const ArticleDetailHeaderView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      children: [
        Text(
          article.title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: color.title,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          children: [
            if (article.author != null)
              Wrap(
                children: [
                  const Text("by"),
                  const SizedBox(width: 2),
                  Text(
                    "${article.author ?? ""}, ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            Text(article.domain)
          ],
        ),
        Text(article.fullFormattedPublishedDate() ?? "")
      ],
    );
  }
}
