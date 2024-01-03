part of 'add_article_tag_bloc.dart';

class AddArticleTagState extends Equatable {
  final List<Tag> allTags;
  final Article article;
  const AddArticleTagState(this.allTags, this.article);

  AddArticleTagState copyWith({
    List<Tag>? allTags,
    Article? article,
  }) {
    return AddArticleTagState(
      allTags ?? this.allTags,
      article ?? this.article,
    );
  }

  @override
  List<Object?> get props => [allTags, article];
}

class AddArticleTagInitial extends AddArticleTagState {
  const AddArticleTagInitial(super.allTags, super.article);
}

class AddArticleTagRemoved extends AddArticleTagState {
  final Tag removedTag;
  const AddArticleTagRemoved(super.allTags, super.article, this.removedTag);
}

class AddArticleTagAdded extends AddArticleTagState {
  final Tag addedTag;
  const AddArticleTagAdded(super.allTags, super.article, this.addedTag);
}
