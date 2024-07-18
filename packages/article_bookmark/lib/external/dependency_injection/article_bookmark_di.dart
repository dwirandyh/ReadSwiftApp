import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:get_it/get_it.dart';
import 'package:network/network.dart';

import '../../repository/tag_repository.dart';

class ArticleBookmarkDI {
  static void setup() {
    GetIt.I.registerFactory<TagRepositoryApi>(
      () => TagRepositoryImpl(
        client: HttpNetwork.client,
      ),
    );
  }
}
