import 'dart:async';

import 'package:network/network.dart';
import 'package:rss_api/rss_api.dart';

abstract class RssRepository extends RssRepositoryApi {
  Future<void> addRssFeed({String? name, required String url});
}

class RssRepositoryImpl extends RssRepository {
  final HttpNetwork client;

  final _rssFeedController = StreamController<List<RssFeed>>.broadcast();
  @override
  Stream<List<RssFeed>> get rssFeeds => _rssFeedController.stream;
  List<RssFeed> _rssFeed = [];

  RssRepositoryImpl({required this.client});

  @override
  Future<void> addRssFeed({String? name, required String url}) async {
    Map<String, dynamic> body = {"name": name, "url": url};
    await client.post(const URLResolver(path: "rss-feed-subscription"),
        body: body);
  }

  @override
  Future<List<RssFeed>> fetchRssFeed() async {
    Map<String, dynamic> response =
        await client.get(const URLResolver(path: "rss-feed-subscription"));
    List rssFeedData = response["data"] as List;
    final rssFeeds = rssFeedData.map((dynamic json) {
      Map<String, dynamic> rssFeed = json['rss_feed'];
      return RssFeed(
        id: json["id"] as int,
        url: rssFeed["url"] as String,
        name: json['name'] as String,
      );
    }).toList();

    _rssFeed = rssFeeds;
    _rssFeedController.add(_rssFeed);
    return rssFeeds;
  }

  @override
  Future<void> deleteRssFeed({required int id}) async {
    await client.delete(URLResolver(path: "rss-feed-subscription/$id"));
    _rssFeed.removeWhere((e) => e.id == id);
    _rssFeedController.add(_rssFeed);
  }

  @override
  Future<List<RssFeed>> orderRss({required List<int> orderedId}) async {
    Map<String, dynamic> body = {"subscriptionIds": orderedId};
    Map<String, dynamic> response = await client.put(
        const URLResolver(path: "rss-feed-subscription-order"),
        body: body);

    List rssFeedData = response["data"] as List;
    final rssFeed = rssFeedData.map((dynamic json) {
      Map<String, dynamic> rssFeed = json['rss_feed'];
      return RssFeed(
        id: json["id"] as int,
        url: rssFeed["url"] as String,
        name: json['name'] as String,
      );
    }).toList();

    _rssFeed = rssFeed;
    _rssFeedController.add(_rssFeed);
    return rssFeed;
  }

  @override
  Future<RssFeed> editRss(
      {required int id, String? name, required String url}) async {
    Map<String, dynamic> body = {"url": url};

    if (name != null) {
      body["name"] = name;
    }

    Map<String, dynamic> response = await client.put(
      URLResolver(path: "rss-feed-subscription/$id"),
      body: body,
    );
    final data = response["data"];
    final rssFeed = RssFeed(
      id: data["id"],
      url: data["rss_feed"]["url"],
      name: data["name"],
    );

    final index = _rssFeed.indexWhere((element) => element.id == id);
    _rssFeed[index] = rssFeed;
    _rssFeedController.add(_rssFeed);

    return rssFeed;
  }
}
