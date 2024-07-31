part of 'manage_rss_bloc.dart';

@immutable
sealed class ManageRssEvent {}

final class ManageRssLoadRss extends ManageRssEvent {}

final class ManageRssUpdateList extends ManageRssEvent {
  final List<RssFeed> rss;

  ManageRssUpdateList({required this.rss});
}

final class ManageRssDeleteRss extends ManageRssEvent {
  final int id;

  ManageRssDeleteRss({required this.id});
}

final class ManageRssUpdateOrder extends ManageRssEvent {
  final int oldIndex;
  final int newIndex;

  ManageRssUpdateOrder({required this.oldIndex, required this.newIndex});
}
