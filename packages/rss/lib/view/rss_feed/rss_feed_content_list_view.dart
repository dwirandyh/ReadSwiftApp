import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/bloc/rss_content/rss_content_bloc.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/model/rss_feed.dart';
import 'package:rss/view/rss_feed/rss_content_item.dart';

class RssFeedContentListView extends StatelessWidget {
  const RssFeedContentListView._({super.key});

  static Widget create(RssFeed feed) {
    return BlocProvider(
      create: (context) =>
          RssContentBloc.create(feed)..add(RssContentFetched()),
      child: const RssFeedContentListView._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RssContentBloc, RssContentState>(
      builder: (context, state) {
        List<RssContent> contents = state.contents;
        return ListView.builder(
          itemCount: contents.length,
          itemBuilder: (context, index) {
            RssContent selectedContent = contents[index];
            return RssContentItem(content: selectedContent);
          },
        );
      },
    );
  }
}
