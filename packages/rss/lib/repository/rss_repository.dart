import 'package:network/network.dart';
import 'package:rss_api/rss_api.dart';

abstract class RssRepository extends RssRepositoryApi {
  Future<void> addRssFeed({String? name, required String url});
}

class RssRepositoryImpl extends RssRepository {
  final HttpNetwork client;

  RssRepositoryImpl({required this.client});

  factory RssRepositoryImpl.create() {
    return RssRepositoryImpl(client: HttpNetwork.client);
  }

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
    return rssFeedData.map((dynamic json) {
      Map<String, dynamic> rssFeed = json['rss_feed'];
      return RssFeed(
        id: json["id"] as int,
        url: rssFeed["url"] as String,
        name: json['name'] as String,
      );
    }).toList();
  }

  @override
  Future<void> deleteRssFeed({required int id}) async {
    await client.delete(URLResolver(path: "rss-feed-subscription/$id"));
  }

  @override
  Future<List<RssFeed>> orderRss({required List<int> orderedId}) async {
    Map<String, dynamic> body = {"subscriptionIds": orderedId};
    Map<String, dynamic> response = await client.put(
        const URLResolver(path: "rss-feed-subscription-order"),
        body: body);

    List rssFeedData = response["data"] as List;
    return rssFeedData.map((dynamic json) {
      Map<String, dynamic> rssFeed = json['rss_feed'];
      return RssFeed(
        id: json["id"] as int,
        url: rssFeed["url"] as String,
        name: json['name'] as String,
      );
    }).toList();
  }
}
