import 'package:flutter/material.dart';
import 'package:foundation/foundation.dart';
import 'package:rss/model/rss_content.dart';
import 'package:url_launcher/url_launcher.dart';

class RssContentDetailAppBar extends StatelessWidget {
  static const int _popupMenuAddToBookmark = 0;

  final RssContent? rssContent;

  const RssContentDetailAppBar({super.key, required this.rssContent});

  Future<void> _openOriginalWeb() async {
    if (rssContent?.url == null) {
      return;
    }

    try {
      await launchUrl(Uri.parse(rssContent!.url));
    } catch (_) {}
  }

  void _shareContent(BuildContext context) {
    if (rssContent == null) {
      return;
    }

    ShareUtil.shareText(context,
        "Check out this article ${rssContent!.title} \n${rssContent!.url}");
  }

  List<Widget> _appBarActions(BuildContext context) {
    return [
      IconButton(
        onPressed: _openOriginalWeb,
        icon: const Icon(Icons.open_in_browser),
      ),
      IconButton(
        onPressed: () {
          _shareContent(context);
        },
        icon: const Icon(Icons.share),
      ),
      PopupMenuButton(
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: _popupMenuAddToBookmark,
              child: Wrap(
                spacing: 8,
                children: [
                  Icon(Icons.bookmark),
                  Text("Bookmark This"),
                ],
              ),
            ),
          ];
        },
        onSelected: (index) {
          switch (index) {
            case _popupMenuAddToBookmark:
              // TODO: Add rss content to bookmark list
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
      actions: rssContent != null ? _appBarActions(context) : null,
    );
  }
}
