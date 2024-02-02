import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';
import 'package:uikit/web_content_viewer/web_content.dart';

class WebContentHeaderView extends StatelessWidget {
  final WebContent content;
  const WebContentHeaderView({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      children: [
        Text(
          content.title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: color.title,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Wrap(
          children: [
            if (content.author != null)
              Wrap(
                children: [
                  const Text("by"),
                  const SizedBox(width: 2),
                  Text(
                    "${content.author ?? ""}, ",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            Text(content.domain)
          ],
        ),
        Text(content.fullFormattedPublishedDate() ?? "")
      ],
    );
  }
}
