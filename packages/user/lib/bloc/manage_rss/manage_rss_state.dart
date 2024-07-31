part of 'manage_rss_bloc.dart';

enum ManageRssStatus { loading, loaded, error }

final class ManageRssState {
  final ManageRssStatus status;
  final List<RssFeed> rss;

  ManageRssState({required this.status, required this.rss});

  factory ManageRssState.initial() {
    return ManageRssState(status: ManageRssStatus.loading, rss: []);
  }

  ManageRssState copyWith({ManageRssStatus? status, List<RssFeed>? rss}) {
    return ManageRssState(
      status: status ?? this.status,
      rss: rss ?? this.rss,
    );
  }
}
