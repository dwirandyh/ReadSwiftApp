import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/bloc/rss_content/rss_content_bloc.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/model/rss_feed.dart';
import 'package:rss/view/rss_feed/rss_content_item.dart';

class RssFeedContentListView extends StatefulWidget {
  const RssFeedContentListView._({super.key});

  static Widget create(RssFeed? feed) {
    return BlocProvider(
      create: (context) =>
          RssContentBloc.create(feed)..add(RssContentFetched()),
      child: const RssFeedContentListView._(),
    );
  }

  @override
  State<RssFeedContentListView> createState() => _RssFeedContentListViewState();
}

class _RssFeedContentListViewState extends State<RssFeedContentListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<RssContentBloc>().add(RssContentFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RssContentBloc, RssContentState>(
      builder: (context, state) {
        List<RssContent> contents = state.contents;
        if (contents.isEmpty) {
          return const Text(
              "TODO: create widget to inform the rss content is empty");
        }

        return ListView.builder(
          itemCount: contents.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            RssContent selectedContent = contents[index];
            return RssContentItem(content: selectedContent);
          },
        );
      },
    );
  }
}
