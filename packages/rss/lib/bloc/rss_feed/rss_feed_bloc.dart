import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/repository/rss_repository.dart';
import 'package:rss_api/rss_api.dart';

part 'rss_feed_event.dart';
part 'rss_feed_state.dart';

class RssFeedBloc extends Bloc<RssFeedEvent, RssFeedState> {
  final RssRepository rssRepository;
  late final StreamSubscription<List<RssFeed>> _rssFeedSubscription;

  RssFeedBloc({required this.rssRepository}) : super(RssFeedState.initial()) {
    on<RssFeedFetched>(_onRssFeedFetched);
    on<RssFeedSelectedRssChanged>(_onRssFeedSelectedRssChanged);
    on<RssFeedUpdateList>(_onRssFeedUpdateList);

    _rssFeedSubscription = rssRepository.rssFeeds.listen((rssFeeds) {
      add(RssFeedUpdateList(rss: rssFeeds));
    });
  }

  Future<void> _onRssFeedFetched(
      RssFeedFetched event, Emitter<RssFeedState> emit) async {
    try {
      await rssRepository.fetchRssFeed();
    } catch (error) {
      emit(state.copyWith(status: RssFeedStatus.error));
    }
  }

  void _onRssFeedSelectedRssChanged(
      RssFeedSelectedRssChanged event, Emitter<RssFeedState> emit) {
    emit(state.copyWith(selectedRssFeed: event.rssFeed));
  }

  void _onRssFeedUpdateList(
      RssFeedUpdateList event, Emitter<RssFeedState> emit) {
    emit(state.copyWith(rssFeeds: event.rss, status: RssFeedStatus.success));
  }

  @override
  Future<void> close() async {
    await _rssFeedSubscription.cancel();
    return super.close();
  }
}
