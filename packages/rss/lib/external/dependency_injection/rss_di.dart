import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:rss_api/rss_api.dart';

import '../../repository/rss_repository.dart';

class RssDI {
  static void setup() {
    GetIt.I.registerFactory<RssRepositoryApi>(
      () => RssRepositoryImpl(
        client: HttpNetwork.client,
      ),
    );
  }
}
