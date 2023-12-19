import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:article_bookmark/view/article/article_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

class ArticlePerTagSection extends StatelessWidget {
  final Tag? tag;

  const ArticlePerTagSection._({super.key, this.tag});

  static Widget create(Tag? tag) {
    return BlocProvider(
      create: (context) => ArticleBloc(
        articleRepository: ArticleRepositoryImpl(
          client: HttpNetwork.client,
        ),
        tag: tag,
      )..add(ArticleFetched()),
      child: ArticlePerTagSection._(tag: tag),
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
