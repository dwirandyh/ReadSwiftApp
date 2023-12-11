import 'package:article_bookmark/view/article/article_bookmark_header.dart';
import 'package:article_bookmark/view/article/article_per_tag_section.dart';
import 'package:article_bookmark/view/tag/tag_filter_view.dart';
import 'package:flutter/material.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleBookmarkPage extends StatefulWidget {
  const ArticleBookmarkPage._({super.key});

  @override
  State<ArticleBookmarkPage> createState() => _ArticleBookmarkPageState();

  static Widget create() {
    return const ArticleBookmarkPage._();
  }
}

class _ArticleBookmarkPageState extends State<ArticleBookmarkPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final colors = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: ArticleBookmarkHeader(),
            ),
            const SizedBox(
              height: 16,
            ),
            const TagFilterView(),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {},
                children: [
                  ArticlePerTagSection.create(null),
                  ArticlePerTagSection.create(1),
                  ArticlePerTagSection.create(2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
