import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article/article_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleList extends StatefulWidget {
  final List<Article> articles;

  ArticleList({super.key, required this.articles});

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

  @override
  Widget build(BuildContext context) {
    if (widget.articles.isEmpty) {
      return const Center(
        child: Text("TODO: Add widget to encourage user to bookmark article"),
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        Article article = widget.articles[index];
        return ArticleItem(
          article: Article(
            id: article.id,
            title: article.title,
            datePublished: article.datePublished,
            leadImage: article.leadImage,
            content: article.content,
            url: article.url,
            domain: article.domain,
            excerpt: article.excerpt,
            wordCount: article.wordCount,
          ),
        );
      },
      itemCount: widget.articles.length,
      controller: _scrollController,
    );
    ;
  }
}
