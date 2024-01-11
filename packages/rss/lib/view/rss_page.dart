import 'package:flutter/material.dart';
import 'package:rss/view/empty_rss_view.dart';

class RssPage extends StatelessWidget {
  const RssPage._({super.key});

  static Widget create() {
    return const RssPage._();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: EmptyRssView()),
    );
  }
}
