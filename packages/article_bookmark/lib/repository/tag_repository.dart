import 'package:article_bookmark/model/tag.dart';
import 'package:network/network.dart';

abstract class TagRepository {
  Future<List<Tag>> fetchTag({required int page});
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
}
