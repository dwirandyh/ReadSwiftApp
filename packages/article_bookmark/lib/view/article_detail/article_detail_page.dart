import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article_detail/article_detail_app_bar_view.dart';
import 'package:article_bookmark/view/article_detail/article_detail_content_view.dart';
import 'package:article_bookmark/view/article_detail/article_detail_header_view.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  const ArticleDetailPage._({super.key, required this.article});

  static Widget create(Article article) {
    return ArticleDetailPage._(article: article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              ArticleDetailAppBarView(
                article: article,
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ArticleDetailHeaderView(article: article),
                  const SizedBox(height: 16),
                  ArticleDetailContentView(article: article),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
