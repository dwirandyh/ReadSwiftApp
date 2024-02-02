import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;

class Blockquote extends StatelessWidget {
  final dom.Element element;
  const Blockquote({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontStyle: FontStyle.italic),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: element.children
              .map(
                (child) => HtmlWidget(
                  child.outerHtml,
                  key: GlobalKey(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
