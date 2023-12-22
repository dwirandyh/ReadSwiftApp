import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/view/article_detail/html_widget/blockquote.dart';
import 'package:article_bookmark/view/article_detail/html_widget/pre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:uikit/uikit.dart';

class ArticleDetailContentView extends StatelessWidget {
  final Article article;
  const ArticleDetailContentView({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return HtmlWidget(
      article.content ?? "Empty Content",
      customWidgetBuilder: (element) {
        if (element.localName == "blockquote") {
          return Blockquote(element: element);
        }

        if (element.localName == "pre") {
          return Pre(element: element);
        }
      },
      textStyle: TextStyle(color: color.body),
    );
  }
}
