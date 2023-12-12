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
}
