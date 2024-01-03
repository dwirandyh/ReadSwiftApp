import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:network/network.dart';

abstract class ArticleRepository {
  Future<List<Article>> fetchArticle({required int page, required Tag? tag});
  Future<Article> saveToBookmark({required String url});
  Future<void> addTag({required int id, required int tagId});
  Future<void> removeTag({required int id, required int tagId});
  Future<void> deleteArticle({required id});
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
      List tags = json["tags"];
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
        tags: tags.map((e) => Tag(id: e["id"], name: e["name"])).toList(),
      );
    }).toList();
  }

  @override
  Future<Article> saveToBookmark({required String url}) async {
    Map<String, dynamic> body = {"url": url};
    Map<String, dynamic> response =
        await client.post(const URLResolver(path: "article"), body: body);
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

  @override
  Future<void> addTag({required int id, required int tagId}) async {
    Map<String, dynamic> body = {"tag_id": tagId};
    await client.post(URLResolver(path: "article/${id}/add-tag"), body: body);
  }

  @override
  Future<void> removeTag({required int id, required int tagId}) async {
    await client.delete(URLResolver(path: "article/$id/remove-tag/$tagId"));
  }

  @override
  Future<void> deleteArticle({required id}) async {
    await client.delete(URLResolver(path: "article/$id"));
  }
}
