import '../model/rss_feed.dart';

abstract class RssRepositoryApi {
  Stream<List<RssFeed>> get rssFeeds;
  Future<List<RssFeed>> fetchRssFeed();
  Future<void> deleteRssFeed({required int id});
  Future<RssFeed> editRss({
    required int id,
    String? name,
    required String url,
  });
  Future<List<RssFeed>> orderRss({required List<int> orderedId});
}
