import 'package:article_bookmark/domain/entity/article_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleItem extends StatelessWidget {
  final ArticleEntity article;

  const ArticleItem({
    super.key,
    required this.article,
  });

  Widget _thumbnail(BuildContext context) {
    final String? leadImageURL = article.leadImage;
    if (leadImageURL == null) {
      return Placeholder();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: leadImageURL,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12),
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
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
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
                      Text(
                        article.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color.title,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          Text("Aug 20"),
                          Text("•"),
                          Text("5 min read"),
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
