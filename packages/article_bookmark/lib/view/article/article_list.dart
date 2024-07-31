import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/external/article_bookmark_router.dart';
import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article/article_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class ArticleList extends StatefulWidget {
  final List<Article> articles;

  const ArticleList({super.key, required this.articles});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ArticleBloc>().add(ArticleFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _onRefresh() {
    context.read<ArticleBloc>().add(ArticleRefreshed());
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.articles.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MessageDisplayWidget(
              icon: Icons.bookmark_border,
              title: "No articles in this tag yet!",
              subtitle: "Start bookmarking articles to see them here",
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          Article article = widget.articles[index];
          return InkWell(
            onTap: () {
              context.push(
                ArticleBookmarkRouter.articleDetailPage,
                extra: {
                  "article": article,
                  "articleBloc": context.read<ArticleBloc>()
                },
              );
            },
            child: ArticleItem.create(article: article),
          );
        },
        itemCount: widget.articles.length,
        controller: _scrollController,
      ),
    );
  }
}
