import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/model/rss_feed.dart';
import 'package:rss/repository/rss_content_repository.dart';

part 'rss_content_event.dart';
part 'rss_content_state.dart';

class RssContentBloc extends Bloc<RssContentEvent, RssContentState> {
  static RssContentBloc create(RssFeed? feed) {
    return RssContentBloc(
        feed: feed, repository: RssContentRepositoryImpl.create());
  }

  final RssContentRepository repository;
  final RssFeed? feed;
  int page = 1;

  RssContentBloc({this.feed, required this.repository})
      : super(const RssContentState()) {
    on<RssContentFetched>(_onRssContentFetched, transformer: droppable());
    on<RssContentRefreshed>(_onRssContentRefreshed);
  }

  Future<void> _onRssContentFetched(
      RssContentFetched event, Emitter<RssContentState> emit) async {
    if (state.hasReachMax) return;
    try {
      if (state.status == RssContentStatus.initial) {
        List<RssContent> contents =
            await repository.fetchRssContent(feed: feed, page: page);
        return emit(state.copyWith(
            status: RssContentStatus.success,
            contents: contents,
            hasReachMax: false));
      }

      page += 1;
      List<RssContent> contents =
          await repository.fetchRssContent(feed: feed, page: page);
      if (contents.isEmpty) {
        emit(state.copyWith(hasReachMax: true));
      } else {
        emit(
          state.copyWith(
            status: RssContentStatus.success,
            contents: List.of(state.contents)..addAll(contents),
            hasReachMax: false,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: RssContentStatus.failure));
    }
  }

  Future<void> _onRssContentRefreshed(
      RssContentRefreshed event, Emitter<RssContentState> emit) async {
    page = 1;
    emit(const RssContentState());

    await _onRssContentFetched(RssContentFetched(), emit);
  }
}
