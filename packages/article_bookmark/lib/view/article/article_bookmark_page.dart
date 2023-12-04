import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:article_bookmark/view/article/article_bookmark_header.dart';
import 'package:article_bookmark/view/article/article_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleBookmarkPage extends StatefulWidget {
  const ArticleBookmarkPage._({super.key});

  @override
  State<ArticleBookmarkPage> createState() => _ArticleBookmarkPageState();

  static Widget create() {
    return BlocProvider<ArticleBloc>(
      create: (_) => ArticleBloc(
          articleRepository: ArticleRepositoryImpl(client: HttpNetwork.client))
        ..add(ArticleFetched()),
      child: const ArticleBookmarkPage._(),
    );
  }
}

class _ArticleBookmarkPageState extends State<ArticleBookmarkPage> {
  Widget _articleList(int itemCount) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        switch (state.status) {
          case ArticleStatus.initial:
            return const Center(child: CircularProgressIndicator());
          case ArticleStatus.success:
            return ArticleList(articles: state.articles);
          case ArticleStatus.failure:
            return const Center(child: Text("failed to fetch articles"));
        }
      },
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
