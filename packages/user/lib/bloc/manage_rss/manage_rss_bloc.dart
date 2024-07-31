import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rss_api/rss_api.dart';

part 'manage_rss_event.dart';
part 'manage_rss_state.dart';

class ManageRssBloc extends Bloc<ManageRssEvent, ManageRssState> {
  final RssRepositoryApi rssRepository;
  late final StreamSubscription<List<RssFeed>> _rssFeedSubscription;

  ManageRssBloc({required this.rssRepository})
      : super(ManageRssState.initial()) {
    on<ManageRssLoadRss>(_onManageRssLoadRss);
    on<ManageRssDeleteRss>(_onManageRssDeleteRss);
    on<ManageRssUpdateOrder>(_onManageRssUpdateOrder);
    on<ManageRssUpdateList>(_onManageRssUpdateList);

    _rssFeedSubscription = rssRepository.rssFeeds.listen((rssFeeds) {
      add(ManageRssUpdateList(rss: rssFeeds));
    });
  }

  void _onManageRssLoadRss(
      ManageRssLoadRss event, Emitter<ManageRssState> emit) async {
    emit(state.copyWith(status: ManageRssStatus.loading));
    try {
      await rssRepository.fetchRssFeed();
    } catch (e) {
      emit(state.copyWith(status: ManageRssStatus.error));
    }
  }

  void _onManageRssDeleteRss(
      ManageRssDeleteRss event, Emitter<ManageRssState> emit) async {
    try {
      await rssRepository.deleteRssFeed(id: event.id);
      final List<RssFeed> updatedRss = state.rss;
      updatedRss.removeWhere((rss) => rss.id == event.id);
      emit(state.copyWith(rss: List.of(updatedRss)));
    } catch (e) {
      emit(state.copyWith(status: ManageRssStatus.error));
    }
  }

  void _onManageRssUpdateOrder(
      ManageRssUpdateOrder event, Emitter<ManageRssState> emit) async {
    try {
      final updatedRss = state.rss;
      final RssFeed reorderedRss = updatedRss.removeAt(event.oldIndex);
      updatedRss.insert(event.newIndex, reorderedRss);
      emit(state.copyWith(rss: List.of(updatedRss)));

      final orderedRssIds = updatedRss.map((item) => item.id).toList();
      final rss = await rssRepository.orderRss(orderedId: orderedRssIds);
      emit(state.copyWith(rss: List.of(rss)));
    } catch (e) {
      emit(state.copyWith(status: ManageRssStatus.error));
    }
  }

  void _onManageRssUpdateList(
      ManageRssUpdateList event, Emitter<ManageRssState> emit) {
    emit(state.copyWith(
        rss: List.of(event.rss), status: ManageRssStatus.loaded));
  }

  @override
  Future<void> close() async {
    await _rssFeedSubscription.cancel();
    return super.close();
  }
}
