part of 'rss_feed_bloc.dart';

enum RssFeedStatus { loading, success, error }

class RssFeedState extends Equatable {
  final List<RssFeed> rssFeeds;
  final RssFeed? selectedRssFeed;
  final RssFeedStatus status;

  RssFeedState({
    required this.rssFeeds,
    required this.selectedRssFeed,
    required this.status,
  });

  factory RssFeedState.initial() {
    return RssFeedState(
        rssFeeds: [], selectedRssFeed: null, status: RssFeedStatus.loading);
  }

  RssFeedState copyWith({
    List<RssFeed>? rssFeeds,
    RssFeed? selectedRssFeed,
    RssFeedStatus? status,
  }) {
    return RssFeedState(
      rssFeeds: rssFeeds ?? this.rssFeeds,
      selectedRssFeed: selectedRssFeed ?? this.selectedRssFeed,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [rssFeeds, selectedRssFeed, status];
}
