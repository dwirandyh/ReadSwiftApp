import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rss/view/rss_content_detail/rss_content_detail_page.dart';

class RssRouter {
  RssRouter._();

  static const String rssContentDetailPage = "/rss-content/detail";

  static void goToRssContentDetail(BuildContext context, int id) {
    context.push(
      rssContentDetailPage,
      extra: {"id": id},
    );
  }

  static List<RouteBase> routes = [
    GoRoute(
      path: rssContentDetailPage,
      builder: (context, state) {
        Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return RssContentDetailPage.create(extra["id"]);
      },
    )
  ];
}
