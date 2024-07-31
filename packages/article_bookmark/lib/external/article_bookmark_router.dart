import 'package:article_bookmark/view/article_detail/article_detail_page.dart';
import 'package:go_router/go_router.dart';

class ArticleBookmarkRouter {
  ArticleBookmarkRouter._();

  static const String articleDetailPage = "/article/detail";

  static List<RouteBase> routes = [
    GoRoute(
      path: articleDetailPage,
      builder: (context, state) {
        Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return ArticleDetailPage.create(extra["article"], extra["articleBloc"]);
      },
    )
  ];
}
