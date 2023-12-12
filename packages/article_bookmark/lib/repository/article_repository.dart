import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:network/network.dart';

abstract class ArticleRepository {
  Future<List<Article>> fetchArticle({required int page, required Tag? tag});
  Future<Article> saveToBookmark({required String url});
}

class ArticleRepositoryImpl extends ArticleRepository {
  final HttpNetwork client;

  ArticleRepositoryImpl({required this.client});

  @override
  Future<List<Article>> fetchArticle(
      {required int page, required Tag? tag}) async {
    Map<String, dynamic> parameters = {"page": page};
    if (tag != null) {
      parameters["tag"] = tag.id;
    }
    Map<String, dynamic> response =
        await client.get(URLResolver(path: "article", parameters: parameters));
    List articleData = response["data"] as List;
    return articleData.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Article(
        id: map["id"] as int,
        title: map["title"] as String,
        author: map["author"] as String?,
        datePublished: DateTime.tryParse(map["date_published"]),
        leadImage: map["lead_image_url"] as String?,
        content: map["content"] as String?,
        url: map["url"] as String,
        domain: map["domain"] as String,
        excerpt: map["excerpt"] as String?,
        wordCount: map["word_count"] as int?,
      );
    }).toList();
  }

  @override
  Future<Article> saveToBookmark({required String url}) async {
    Map<String, dynamic> body = {"url": url};
    Map<String, dynamic> response =
        await client.post(const URLResolver(path: "article"), body);
    dynamic articleData = response["data"];
    return Article(
      id: articleData["id"],
      title: articleData["title"],
      author: articleData["author"],
      datePublished: DateTime.tryParse(articleData["date_published"] ?? ""),
      leadImage: articleData["lead_image_url"],
      content: articleData["content"],
      url: articleData["url"],
      domain: articleData["domain"],
      excerpt: articleData["excerpt"],
      wordCount: articleData["word_count"],
    );
  }
}
