import '../model/tag.dart';

abstract class TagRepositoryApi {
  Stream<List<Tag>> get tags;
  Future<List<Tag>> fetchTag();
  Future<Tag> renameTag({required int id, required String name});
  Future<void> deleteTag({required int id});
  Future<List<Tag>> orderTag({required List<int> orderedId});
}
