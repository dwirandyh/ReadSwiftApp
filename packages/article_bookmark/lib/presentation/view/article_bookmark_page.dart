import 'package:article_bookmark/domain/entity/article_entity.dart';
import 'package:article_bookmark/presentation/view/article_bookmark_header.dart';
import 'package:article_bookmark/presentation/view/article_item.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme.dart';

class ArticleBookmarkPage extends StatelessWidget {
  const ArticleBookmarkPage({super.key});

  Widget _articleList(int itemCount) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ArticleItem(
          article: ArticleEntity(
            id: 0,
            title:
                "Deep Dive into Core Location in iOS: Geofencing (Region Monitoring)",
            author: "Dwi Randy H",
            datePublished: DateTime.now(),
            leadImage: "",
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArticleBookmarkHeader(),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: _articleList(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
