import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/bloc/rss_content/rss_content_bloc.dart';
import 'package:rss/external/rss_router.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/view/rss_feed/rss_content_item.dart';
import 'package:rss_api/rss_api.dart';
import 'package:uikit/uikit.dart';

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
    final color = context.theme.uikit;
    return BlocBuilder<RssContentBloc, RssContentState>(
      builder: (context, state) {
        List<RssContent> contents = state.contents;
        if (state.status == RssContentStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (contents.isEmpty &&
            state.status == RssContentStatus.success) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Oops! The RSS feed is empty.",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color.title,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "Don't worry, you can check back later or try another feed to discover interesting content.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: contents.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              RssContent selectedContent = contents[index];
              return InkWell(
                onTap: () {
                  RssRouter.goToRssContentDetail(context, selectedContent.id);
                },
                child: RssContentItem(content: selectedContent),
              );
            },
          );
        }
      },
    );
  }
}
