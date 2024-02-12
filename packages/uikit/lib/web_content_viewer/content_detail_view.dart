import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:uikit/uikit.dart';
import 'package:uikit/web_content_viewer/html_widget/blockquote.dart';
import 'package:uikit/web_content_viewer/html_widget/pre.dart';
import 'package:uikit/web_content_viewer/web_content.dart';

class ContentDetailView extends StatelessWidget {
  final WebContent content;
  const ContentDetailView({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return HtmlWidget(
      content.content ?? "Empty Content",
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
