import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:uikit/uikit.dart';

class Pre extends StatelessWidget {
  final dom.Element element;

  const Pre({Key? key, required this.element}) : super(key: key);

  String _extractPreContent(String html) {
    // Use a regular expression to match everything inside <pre> tags
    RegExp regExp =
        RegExp(r'<pre[^>]*>.*?<\/pre>', multiLine: true, dotAll: true);
    String? match = regExp.firstMatch(html)?.group(0);

    // If a match is found, extract the content inside <pre> and remove HTML tags
    if (match != null) {
      String content = match.replaceAll("<br>", "\n");
      content = content.replaceAll(RegExp(r'<[^>]*>'), '');

      // Replace HTML entities with actual characters
      content = content.replaceAll('&quot;', '"').replaceAll('&apos;', "'");

      // Replace <br> tags with actual line breaks
      content = content.replaceAll('<br>', '\n');
      // content = content.replaceAll(r'\n', '\n');

      return content;
    }

    return ''; // Return an empty string if no match is found
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Container(
      decoration: BoxDecoration(
        color: color.preTheme.background,
        border: Border.all(color: color.preTheme.borderColor, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          fontStyle: FontStyle.normal,
          color: color.preTheme.textColor,
        ),
        child: HtmlWidget(
          "<pre>${_extractPreContent(element.outerHtml)}</pre>",
        ),
      ),
    );
  }
}
