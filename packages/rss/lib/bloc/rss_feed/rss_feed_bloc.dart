import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/model/rss_feed.dart';
import 'package:rss/repository/rss_repository.dart';

part 'rss_feed_event.dart';
part 'rss_feed_state.dart';

class RssFeedBloc extends Bloc<RssFeedEvent, RssFeedState> {
  final RssRepository rssRepository;

  RssFeedBloc({required this.rssRepository}) : super(RssFeedState.initial()) {
    on<RssFeedFetched>(_onRssFeedFetched);
    on<RssFeedSelectedRssChanged>(_onRssFeedSelectedRssChanged);
  }

  factory RssFeedBloc.create() {
    return RssFeedBloc(rssRepository: RssRepositoryImpl.create());
  }

  Future<void> _onRssFeedFetched(
      RssFeedFetched event, Emitter<RssFeedState> emit) async {
    try {
      List<RssFeed> rssFeeds = await rssRepository.fetchRssFeed();
      emit(state.copyWith(rssFeeds: rssFeeds, status: RssFeedStatus.success));
    } catch (error) {
      emit(state.copyWith(status: RssFeedStatus.error));
    }
  }

  void _onRssFeedSelectedRssChanged(
      RssFeedSelectedRssChanged event, Emitter<RssFeedState> emit) {
    emit(state.copyWith(selectedRssFeed: event.rssFeed));
  }
}
