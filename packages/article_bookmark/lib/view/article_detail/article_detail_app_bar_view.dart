import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article/article_tag/add_article_tag_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foundation/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailAppBarView extends StatelessWidget {
  final Article article;
  const ArticleDetailAppBarView({super.key, required this.article});

  static const int _popupMenuAddToTag = 0;
  static const int _popupMenuDelete = 1;

  Future<void> openOriginalWeb() async {
    try {
      await launchUrl(Uri.parse(article.url));
    } catch (_) {}
  }

  Future<void> shareArticle(BuildContext context) async {
    String sharedText =
        "Check out this story i saved on ReadSwift \n${article.url}";
    bool isIpad = await DeviceInfo.isIpad();
    if (isIpad && context.mounted) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        await Share.share(sharedText,
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }
    } else {
      await Share.share(sharedText);
    }
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      IconButton(
        onPressed: openOriginalWeb,
        icon: const Icon(Icons.open_in_browser),
      ),
      IconButton(
        onPressed: () {
          shareArticle(context);
        },
        icon: const Icon(Icons.share),
      ),
      PopupMenuButton(
        icon: const Icon(Icons.more_vert_outlined),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: _popupMenuAddToTag,
              child: Wrap(
                spacing: 8,
                children: [
                  Icon(Icons.playlist_add),
                  Text("Add to Tags"),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: _popupMenuDelete,
              child: Wrap(
                spacing: 8,
                children: [
                  Icon(Icons.delete),
                  Text("Delete"),
                ],
              ),
            ),
          ];
        },
        onSelected: (index) {
          switch (index) {
            case _popupMenuAddToTag:
              AddArticleTagView.show(
                  context: context,
                  article: article,
                  articleTags: article.tags);
              break;
            case _popupMenuDelete:
              context.read<ArticleBloc>().add(ArticleDeleted(article: article));
              break;
          }
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 50,
      floating: true,
      snap: true,
      actions: _appBarActions(context),
    );
  }
}
