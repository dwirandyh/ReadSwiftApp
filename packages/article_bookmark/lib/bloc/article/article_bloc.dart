import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/repository/article_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'article_event.dart';
part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository articleRepository;
  final Tag? tag;
  int page = 1;

  ArticleBloc({required this.articleRepository, this.tag})
      : super(const ArticleState()) {
    on<ArticleFetched>(_onArticleFetched, transformer: droppable());
    on<ArticleTagAdded>(_onArticleTagAdded);
    on<ArticleTagRemoved>(_onArticleTagRemoved);
    on<ArticleRefreshed>(_onArticleRefreshed);
    on<ArticleDeleted>(_onArticleDeleted);
  }

  Future<void> _onArticleFetched(
    ArticleFetched event,
    Emitter<ArticleState> emit,
  ) async {
    if (state.hasReachMax) return;
    try {
      if (state.status == ArticleStatus.initial) {
        List<Article> articles =
            await articleRepository.fetchArticle(page: page, tag: tag);
        return emit(
          state.copyWith(
            status: ArticleStatus.success,
            articles: articles,
            hasReachMax: false,
          ),
        );
      }

      page += 1;
      List<Article> articles =
          await articleRepository.fetchArticle(page: page, tag: tag);
      if (articles.isEmpty) {
        emit(state.copyWith(hasReachMax: true));
      } else {
        emit(
          state.copyWith(
            status: ArticleStatus.success,
            articles: List.of(state.articles)..addAll(articles),
            hasReachMax: false,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: ArticleStatus.failure));
    }
  }

  Future<void> _onArticleRefreshed(
    ArticleRefreshed event,
    Emitter<ArticleState> emit,
  ) async {
    page = 1;
    emit(state.copyWith(hasReachMax: false));

    await _onArticleFetched(ArticleFetched(), emit);
  }

  Future<void> _onArticleTagAdded(
      ArticleTagAdded event, Emitter<ArticleState> emit) async {
    try {
      final List<Article> updatedArticles = state.articles.map((element) {
        return (element.id == event.article.id)
            ? element.copyWith(tags: [...element.tags, event.tag])
            : element;
      }).toList();

      emit(state.copyWith(articles: updatedArticles));
    } catch (_) {}
  }

  Future<void> _onArticleTagRemoved(
      ArticleTagRemoved event, Emitter<ArticleState> emit) async {
    try {
      final List<Article> updatedArticles = List.of(state.articles);
      updatedArticles
          .removeWhere((element) => element.tags.contains(event.tag));

      emit(state.copyWith(articles: updatedArticles));
    } catch (_) {}
  }

  Future<void> _onArticleDeleted(
      ArticleDeleted event, Emitter<ArticleState> emit) async {
    try {
      await articleRepository.deleteArticle(id: event.article.id);
      final List<Article> updatedArticles = List.of(state.articles);
      updatedArticles.removeWhere((element) => element == event.article);

      emit(state.copyWith(articles: updatedArticles));
    } catch (error) {
      print(error);
    }
  }
}
