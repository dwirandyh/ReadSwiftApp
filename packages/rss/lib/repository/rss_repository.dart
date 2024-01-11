import 'package:network/network.dart';

abstract class RssRepository {
  Future<void> addRssFeed({String? name, required String url});
}

class RssRepositoryImpl extends RssRepository {
  final HttpNetwork client;

  RssRepositoryImpl({required this.client});

  @override
  Future<void> addRssFeed({String? name, required String url}) async {
    Map<String, dynamic> body = {"name": name, "url": url};
    await client.post(const URLResolver(path: "rss-feed"), body: body);
  }
}
