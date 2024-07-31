import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:get_it/get_it.dart';
import 'package:network/network.dart';

import '../../repository/tag_repository.dart';

class ArticleBookmarkDI {
  static void setup() {
    GetIt.I.registerLazySingleton<TagRepository>(
      () => TagRepositoryImpl(client: HttpNetwork.client),
    );

    GetIt.I.registerLazySingleton<TagRepositoryApi>(
      () => GetIt.I.get<TagRepository>(),
    );
  }
}
