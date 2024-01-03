part of 'add_article_tag_bloc.dart';

abstract class AddArticleTagEvent extends Equatable {
  const AddArticleTagEvent();
}

class AddArticleTagFetched extends AddArticleTagEvent {
  @override
  List<Object?> get props => [];
}

class AddArticleTagAddRequested extends AddArticleTagEvent {
  final Article article;
  final Tag tag;

  const AddArticleTagAddRequested({required this.article, required this.tag});

  @override
  List<Object?> get props => [article, tag];
}

class AddArticleTagRemoveRequested extends AddArticleTagEvent {
  final Article article;
  final Tag tag;

  const AddArticleTagRemoveRequested(
      {required this.article, required this.tag});

  @override
  // TODO: implement props
  List<Object?> get props => [article, tag];
}
