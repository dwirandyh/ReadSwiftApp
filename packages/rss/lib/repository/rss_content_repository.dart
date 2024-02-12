import 'package:network/network.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/model/rss_feed.dart';

abstract class RssContentRepository {
  Future<List<RssContent>> fetchRssContent(
      {required RssFeed? feed, required int page});
  Future<RssContent> fetchRssContentDetail({required int id});
  Future<void> addToBookmark({required int id});
}

class RssContentRepositoryImpl extends RssContentRepository {
  static RssContentRepositoryImpl create() {
    return RssContentRepositoryImpl(client: HttpNetwork.client);
  }

  final HttpNetwork client;

  RssContentRepositoryImpl({required this.client});

  @override
  Future<List<RssContent>> fetchRssContent(
      {required RssFeed? feed, required int page}) async {
    Map<String, dynamic> parameters = {"page": page};

    if (feed != null) {
      parameters["feedId"] = feed.id;
    }

    Map<String, dynamic> response = await client
        .get(URLResolver(path: 'rss-content', parameters: parameters));

    List rssContentData = response["data"] as List;
    return rssContentData.map((dynamic json) {
      return RssContent(
        id: json["id"] as int,
        title: json["title"] as String,
        author: json["author"] as String?,
        datePublished: DateTime.tryParse(json["date_published"]),
        leadImage: json["lead_image_url"] as String?,
        content: json["content"] as String?,
        url: json["url"] as String,
        domain: json["domain"] as String,
        excerpt: json["excerpt"] as String?,
        wordCount: json["word_count"] as int?,
      );
    }).toList();
  }

  @override
  Future<RssContent> fetchRssContentDetail({required int id}) async {
    Map<String, dynamic> response =
        await client.get(URLResolver(path: "rss-content/$id"));
    dynamic contentData = response["data"];
    return RssContent(
      id: contentData["id"] as int,
      title: contentData["title"] as String,
      author: contentData["author"] as String?,
      datePublished: DateTime.tryParse(contentData["date_published"]),
      leadImage: contentData["lead_image_url"] as String?,
      content: contentData["content"] as String?,
      url: contentData["url"] as String,
      domain: contentData["domain"] as String,
      excerpt: contentData["excerpt"] as String?,
      wordCount: contentData["word_count"] as int?,
    );
  }

  @override
  Future<void> addToBookmark({required int id}) async {
    await client.post(URLResolver(path: "rss-content/$id/bookmark"));
  }
}
