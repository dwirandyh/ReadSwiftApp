import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article_bookmark_header.dart';
import 'package:article_bookmark/view/article_item.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleBookmarkPage extends StatelessWidget {
  const ArticleBookmarkPage({super.key});

  Widget _articleList(int itemCount) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ArticleItem(
          article: Article(
            id: 0,
            title:
                "Deep Dive into Core Location in iOS: Geofencing (Region Monitoring)",
            author: "Dwi Randy H",
            datePublished: DateTime.now(),
            leadImage:
                "https://miro.medium.com/v2/resize:fit:4800/0*EOwLviJ4rkdIC_Q9",
            content: "Content of deep dive into core location",
            url:
                "https://dwirandyh.medium.com/deep-dive-into-core-location-in-ios-geofencing-region-monitoring-7846802c968e",
            domain: "dwirandyh.medium.com",
            excerpt:
                "Explore Geofencing to Detect User Entry and Exit from Specific Locations.",
            wordCount: 1661,
          ),
        );
      },
      itemCount: itemCount,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: ArticleBookmarkHeader(),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: _articleList(5),
            ),
          ],
        ),
      ),
    );
  }
}
