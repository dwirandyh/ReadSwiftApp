import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rss/model/rss_content.dart';
import 'package:uikit/uikit.dart';

class RssContentItem extends StatelessWidget {
  final RssContent content;
  const RssContentItem({super.key, required this.content});

  Widget _thumbnail(BuildContext context) {
    final String? leadImageURL = content.leadImage;
    if (leadImageURL == null) {
      return const SizedBox();
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: leadImageURL,
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget _thumbnailAction(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.playlist_add),
          ),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ),
        SizedBox(
          width: 24,
          height: 24,
          child: IconButton(
            iconSize: 24,
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
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
                      Text(content.domain),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 70,
                        child: Text(
                          content.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: color.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                _thumbnail(context)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Wrap(
                  spacing: 8,
                  children: [
                    Text(
                      content.formattedPublishedDate() ?? "",
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
                      content.estimatedReadingTime() ?? "",
                      style: TextStyle(
                        color: color.caption,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _thumbnailAction(context)
              ],
            ),
          ),
          Divider(
            color: color.caption,
          )
        ],
      ),
    );
  }
}
