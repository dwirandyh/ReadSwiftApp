import 'package:article_bookmark/model/article.dart';
import 'package:flutter/widgets.dart';
import 'package:foundation/foundation.dart';
import 'package:share_plus/share_plus.dart';

class ArticleActionUtility {
  static Future<void> shareArticle(
      BuildContext context, Article article) async {
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
}
