import 'package:article_bookmark/model/article.dart';
import 'package:network/network.dart';

abstract class ArticleRepository {
  Future<Article> saveToBookmark({required String url});
}

class ArticleRepositoryImpl extends ArticleRepository {
  final HttpNetwork client;

  ArticleRepositoryImpl({required this.client});

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
