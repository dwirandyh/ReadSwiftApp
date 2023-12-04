part of 'article_bloc.dart';

sealed class ArticleEvent extends Equatable {
  const ArticleEvent();
}

class ArticleFetched extends ArticleEvent {
  @override
  List<Object?> get props => [];
}
