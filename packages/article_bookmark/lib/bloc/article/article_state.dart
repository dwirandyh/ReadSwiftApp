part of 'article_bloc.dart';

enum ArticleStatus {
  initial,
  success,
  failure,
}

final class ArticleState extends Equatable {
  final ArticleStatus status;
  final List<Article> articles;
  final bool hasReachMax;

  const ArticleState({
    this.status = ArticleStatus.initial,
    this.articles = const <Article>[],
    this.hasReachMax = false,
  });

  ArticleState copyWith(
      {ArticleStatus? status, List<Article>? articles, bool? hasReachMax}) {
    return ArticleState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      hasReachMax: hasReachMax ?? this.hasReachMax,
    );
  }

  @override
  List<Object?> get props => [status, articles, hasReachMax];
}
