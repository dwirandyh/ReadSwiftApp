import 'package:article_bookmark/model/article.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailAppBarView extends StatelessWidget {
  final Article article;
  const ArticleDetailAppBarView({super.key, required this.article});

  Future<void> openOriginalWeb() async {
    try {
      await launchUrl(Uri.parse(article.url));
    } catch (_) {}
  }

  List<Widget> _appBarActions() {
    return [
      IconButton(
        onPressed: openOriginalWeb,
        icon: const Icon(Icons.open_in_browser),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.share),
      ),
      PopupMenuButton(
        icon: const Icon(Icons.more_vert_outlined),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Wrap(
                spacing: 8,
                children: [
                  Icon(Icons.playlist_add),
                  Text("Add to Tags"),
                ],
              ),
            ),
            const PopupMenuItem<int>(
              value: 0,
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
        onSelected: (index) {},
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 50,
      floating: true,
      snap: true,
      actions: _appBarActions(),
    );
  }
}
