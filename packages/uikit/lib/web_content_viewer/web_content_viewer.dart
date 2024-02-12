import 'package:flutter/widgets.dart';
import 'package:uikit/web_content_viewer/content_detail_view.dart';
import 'package:uikit/web_content_viewer/web_content.dart';
import 'package:uikit/web_content_viewer/web_content_header_view.dart';

class WebContentViewer extends StatelessWidget {
  final WebContent content;
  const WebContentViewer({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          WebContentHeaderView(content: content),
          const SizedBox(height: 16),
          ContentDetailView(content: content),
        ],
      ),
    );
  }
}
