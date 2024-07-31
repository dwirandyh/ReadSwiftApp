import 'package:article_bookmark/article_bookmark.dart';
import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:article_bookmark/view/article/article_list.dart';
import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

class ArticlePerTagSection extends StatelessWidget {
  final Tag? tag;

  const ArticlePerTagSection._({super.key, this.tag});

  static Widget create(BuildContext context, Tag? tag) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ArticleBloc(
            articleRepository: ArticleRepositoryImpl(
              client: HttpNetwork.client,
            ),
            tag: tag,
          )..add(ArticleFetched()),
        ),
        BlocProvider<BookmarkClipboardBloc>.value(
          value: BlocProvider.of<BookmarkClipboardBloc>(context),
        ),
      ],
      child: BlocListener<BookmarkClipboardBloc, BookmarkClipboardState>(
        listener: (context, state) {
          if (tag == null && state is BookmarkClipboardSaved) {
            context.read<ArticleBloc>().add(ArticleRefreshed());
          }
        },
        child: ArticlePerTagSection._(tag: tag),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
}
