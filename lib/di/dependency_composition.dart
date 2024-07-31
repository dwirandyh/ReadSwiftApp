import 'package:article_bookmark/article_bookmark.dart';
import 'package:authentication/authentication.dart';
import 'package:rss/rss.dart';
import 'package:user/user.dart';

class DependencyComposition {
  static void setup() {
    ArticleBookmarkDI.setup();
    AuthenticationDI.setup();
    RssDI.setup();
    UserDI.setup();
  }
}
