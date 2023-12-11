import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:article_bookmark/view/article/article_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

class ArticlePerTagSection extends StatelessWidget {
  final int? tagId;

  const ArticlePerTagSection._({super.key, this.tagId});

  static Widget create(int? tagId) {
    return BlocProvider(
      create: (context) => ArticleBloc(
        articleRepository: ArticleRepositoryImpl(
          client: HttpNetwork.client,
        ),
        tagId: tagId,
      )..add(ArticleFetched()),
      child: ArticlePerTagSection._(tagId: tagId),
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
