import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:network/network.dart';

abstract class TagRepository extends TagRepositoryApi {
  @override
  Future<List<Tag>> fetchTag({required int page});
  Future<Tag> addTag({required String tag});
}

class TagRepositoryImpl extends TagRepository {
  final HttpNetwork client;

  TagRepositoryImpl({required this.client});

  @override
  Future<List<Tag>> fetchTag({required int page}) async {
    Map<String, dynamic> parameters = {"page": page};
    Map<String, dynamic> response =
        await client.get(URLResolver(path: "tag", parameters: parameters));
    List tagData = response["data"];
    return tagData.map((dynamic json) {
      final Map<String, dynamic> map = json;
      return Tag(
        id: map["id"] as int,
        name: map["name"] as String,
      );
    }).toList();
  }

  @override
  Future<Tag> addTag({required String tag}) async {
    Map<String, dynamic> body = {"name": tag};
    Map<String, dynamic> response =
        await client.post(const URLResolver(path: "tag"), body: body);
    return Tag(
      id: response["data"]["id"],
      name: response["data"]["name"],
    );
  }

  @override
  Future<Tag> renameTag({required int id, required String name}) async {
    Map<String, dynamic> body = {"name": name};
    Map<String, dynamic> response =
        await client.put(URLResolver(path: "tag/$id"), body: body);
    return Tag(
      id: response["data"]["id"],
      name: response["data"]["name"],
    );
  }

  @override
  Future<void> deleteTag({required int id}) async {
    await client.delete(URLResolver(path: "tag/$id"));
  }

  @override
  Future<List<Tag>> orderTag({required List<int> orderedId}) async {
    Map<String, dynamic> body = {"tagIds": orderedId};
    Map<String, dynamic> response =
        await client.put(const URLResolver(path: "tag-order"), body: body);

    List tagData = response["data"];
    return tagData.map((dynamic json) {
      final Map<String, dynamic> map = json;
      return Tag(
        id: map["id"] as int,
        name: map["name"] as String,
      );
    }).toList();
  }
}
