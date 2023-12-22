import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article_detail/article_detail_page.dart';
import 'package:go_router/go_router.dart';

class ArticleBookmarkRouter {
  ArticleBookmarkRouter._();

  static const String articleDetailPage = "/article/detail";

  static List<RouteBase> routes = [
    GoRoute(
      path: articleDetailPage,
      builder: (context, state) {
        Article article = state.extra as Article;
        return ArticleDetailPage.create(article);
      },
    )
  ];
}
