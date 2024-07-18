import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_article_tag_event.dart';
part 'add_article_tag_state.dart';

class AddArticleTagBloc extends Bloc<AddArticleTagEvent, AddArticleTagState> {
  final Article article;
  final TagRepository tagRepository;
  final ArticleRepository articleRepository;

  AddArticleTagBloc(
      {required this.article,
      required this.tagRepository,
      required this.articleRepository})
      : super(AddArticleTagInitial(const [], article)) {
    on<AddArticleTagFetched>(_onAddArticleTagFetched);
    on<AddArticleTagAddRequested>(_onAddArticleTagAdded);
    on<AddArticleTagRemoveRequested>(_onAddArticleTagRemoved);
  }

  Future<void> _onAddArticleTagFetched(
    AddArticleTagFetched event,
    Emitter<AddArticleTagState> emit,
  ) async {
    try {
      List<Tag> tags = await tagRepository.fetchTag(page: 1);
      emit(AddArticleTagInitial(tags, article));
    } catch (_) {}
  }

  Future<void> _onAddArticleTagAdded(
      AddArticleTagAddRequested event, Emitter<AddArticleTagState> emit) async {
    try {
      await articleRepository.addTag(id: event.article.id, tagId: event.tag.id);
      final List<Tag> updatedTags = List.of(state.article.tags)..add(event.tag);
      final Article updatedArticle = state.article.copyWith(tags: updatedTags);

      emit(AddArticleTagAdded(state.allTags, updatedArticle, event.tag));
    } catch (_) {}
  }

  Future<void> _onAddArticleTagRemoved(AddArticleTagRemoveRequested event,
      Emitter<AddArticleTagState> emit) async {
    try {
      await articleRepository.removeTag(
          id: event.article.id, tagId: event.tag.id);
      final List<Tag> updatedTags = List.of(state.article.tags)
        ..removeWhere((element) => element == event.tag);
      final Article updatedArticle = state.article.copyWith(tags: updatedTags);

      emit(AddArticleTagRemoved(state.allTags, updatedArticle, event.tag));
    } catch (_) {}
  }
}
