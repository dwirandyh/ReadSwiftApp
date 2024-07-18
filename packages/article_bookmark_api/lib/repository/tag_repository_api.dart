import '../model/tag.dart';

abstract class TagRepositoryApi {
  Future<List<Tag>> fetchTag({required int page});
  Future<Tag> renameTag({required int id, required String name});
  Future<void> deleteTag({required int id});
}
