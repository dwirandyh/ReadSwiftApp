part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class ArticleFetched extends ArticleEvent {
  @override
  List<Object?> get props => [];
}

class ArticleRemovedFromTag extends ArticleEvent {
  final Article article;
  final Tag tag;

  const ArticleRemovedFromTag({required this.article, required this.tag});

  @override
  List<Object?> get props => [article, tag];
}

class ArticleRefreshed extends ArticleEvent {
  @override
  List<Object?> get props => [];
}

class ArticleTagAdded extends ArticleEvent {
  final Article article;
  final Tag tag;

  const ArticleTagAdded({required this.article, required this.tag});

  @override
  List<Object?> get props => [article, tag];
}

class ArticleTagRemoved extends ArticleEvent {
  final Article article;
  final Tag tag;

  const ArticleTagRemoved({required this.article, required this.tag});

  @override
  List<Object?> get props => [article, tag];
}
