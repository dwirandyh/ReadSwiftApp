part of 'rss_feed_bloc.dart';

abstract class RssFeedEvent extends Equatable {
  const RssFeedEvent();
}

class RssFeedUpdateList extends RssFeedEvent {
  final List<RssFeed> rss;

  const RssFeedUpdateList({required this.rss});

  @override
  List<Object?> get props => [];
}

class RssFeedFetched extends RssFeedEvent {
  @override
  List<Object?> get props => [];
}

class RssFeedSelectedRssChanged extends RssFeedEvent {
  final RssFeed? rssFeed;

  const RssFeedSelectedRssChanged({this.rssFeed});

  @override
  List<Object?> get props => [rssFeed];
}
