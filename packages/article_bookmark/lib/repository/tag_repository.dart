import 'dart:async';

import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:network/network.dart';

abstract class TagRepository extends TagRepositoryApi {
  Future<Tag> addTag({required String tag});
}

class TagRepositoryImpl extends TagRepository {
  final HttpNetwork client;

  final _tagController = StreamController<List<Tag>>.broadcast();
  @override
  Stream<List<Tag>> get tags => _tagController.stream;
  List<Tag> _tags = [];

  TagRepositoryImpl({required this.client});

  @override
  Future<List<Tag>> fetchTag() async {
    Map<String, dynamic> response =
        await client.get(const URLResolver(path: "tag"));
    List data = response["data"];
    final tags = data.map((dynamic json) {
      final Map<String, dynamic> map = json;
      return Tag(
        id: map["id"] as int,
        name: map["name"] as String,
      );
    }).toList();

    _tags = tags;
    _tagController.add(_tags);
    return tags;
  }

  @override
  Future<Tag> addTag({required String tag}) async {
    Map<String, dynamic> body = {"name": tag};
    Map<String, dynamic> response =
        await client.post(const URLResolver(path: "tag"), body: body);
    final newTag = Tag(
      id: response["data"]["id"],
      name: response["data"]["name"],
    );

    _tags.add(newTag);
    _tagController.add(_tags);

    return newTag;
  }

  @override
  Future<Tag> renameTag({required int id, required String name}) async {
    Map<String, dynamic> body = {"name": name};
    Map<String, dynamic> response =
        await client.put(URLResolver(path: "tag/$id"), body: body);
    final updatedTag = Tag(
      id: response["data"]["id"],
      name: response["data"]["name"],
    );

    final index = _tags.indexWhere((element) => element.id == id);
    _tags[index] = updatedTag;
    _tagController.add(_tags);
    return updatedTag;
  }

  @override
  Future<void> deleteTag({required int id}) async {
    await client.delete(URLResolver(path: "tag/$id"));
    _tags.removeWhere((e) => e.id == id);
    _tagController.add(_tags);
  }

  @override
  Future<List<Tag>> orderTag({required List<int> orderedId}) async {
    Map<String, dynamic> body = {"tagIds": orderedId};
    Map<String, dynamic> response =
        await client.put(const URLResolver(path: "tag-order"), body: body);

    List data = response["data"];
    final tags = data.map((dynamic json) {
      final Map<String, dynamic> map = json;
      return Tag(
        id: map["id"] as int,
        name: map["name"] as String,
      );
    }).toList();

    _tags = tags;
    _tagController.add(_tags);
    return tags;
  }
}
