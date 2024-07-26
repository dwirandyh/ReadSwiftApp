import '../model/rss_feed.dart';

abstract class RssRepositoryApi {
  Future<List<RssFeed>> fetchRssFeed();
}
