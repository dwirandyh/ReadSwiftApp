import '../model/tag.dart';

abstract class TagRepositoryApi {
  Future<List<Tag>> fetchTag({required int page});
  Future<void> deleteTag({required int id});
}
