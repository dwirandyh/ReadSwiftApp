import 'package:flutter/widgets.dart';
import 'package:rss/view/add_rss/add_rss_view.dart';
import 'package:uikit/uikit.dart';

class EmptyRssView extends StatelessWidget {
  const EmptyRssView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Image.asset(
                "assets/ill_rss.png",
                package: "rss",
              ),
              width: 240,
              height: 240,
            ),
            Text(
              "Never miss an update",
              style: TextStyle(
                color: color.title,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Add your favorite websites and blogs to stay on top of the latest news and stories, all in one place.",
              style: TextStyle(
                color: color.subtitle,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            UIKitButton(
              onPressed: () {
                AddRssView.show(context);
              },
              text: "Add an RSS Feed",
            )
          ],
        ),
      ),
    );
  }
}
