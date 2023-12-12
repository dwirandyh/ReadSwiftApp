import 'package:article_bookmark/model/article.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleItem extends StatelessWidget {
  final Article article;

  const ArticleItem({
    super.key,
    required this.article,
  });

  Widget _thumbnail(BuildContext context) {
    final String? leadImageURL = article.leadImage;
    if (leadImageURL == null) {
      return const Placeholder();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: leadImageURL,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 24,
            children: [
              SizedBox(
                height: 16,
                width: 16,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(Icons.star_border),
                ),
              ),
              SizedBox(
                height: 16,
                width: 16,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(Icons.share),
                ),
              ),
              SizedBox(
                height: 16,
                width: 16,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              )
            ],
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<UIKitThemeColor>()!;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(article.domain),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 70,
                        child: Text(
                          article.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Text(
                            article.formattedPublishedDate() ?? "",
                            style: TextStyle(
                              color: color.caption,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            "•",
                            style: TextStyle(
                              color: color.caption,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            article.estimatedReadingTime() ?? "",
                            style: TextStyle(
                              color: color.caption,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _thumbnail(context)
              ],
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: color.caption,
          )
        ],
      ),
    );
  }
}
