import '../model/rss_feed.dart';

abstract class RssRepositoryApi {
  Future<List<RssFeed>> fetchRssFeed();
  Future<void> deleteRssFeed({required int id});
  Future<List<RssFeed>> orderRss({required List<int> orderedId});
}
