import 'package:network/network.dart';
import 'package:rss/model/rss_feed.dart';

abstract class RssRepository {
  Future<void> addRssFeed({String? name, required String url});
  Future<List<RssFeed>> fetchRssFeed();
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
    await client.post(const URLResolver(path: "rss-feed"), body: body);
  }

  @override
  Future<List<RssFeed>> fetchRssFeed() async {
    Map<String, dynamic> response =
        await client.get(const URLResolver(path: "rss-feed"));
    List rssFeedData = response["data"] as List;
    return rssFeedData.map((dynamic json) {
      return RssFeed(
        id: json["id"] as int,
        url: json["url"] as String,
        name: json["name"] as String,
      );
    }).toList();
  }
}
