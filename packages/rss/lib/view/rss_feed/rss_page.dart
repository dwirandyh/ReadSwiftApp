import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/bloc/rss_feed/rss_feed_bloc.dart';
import 'package:rss/model/rss_feed.dart';
import 'package:rss/view/rss_feed/empty_rss_view.dart';
import 'package:rss/view/rss_feed/rss_feed_content_list_view.dart';
import 'package:rss/view/rss_feed/rss_feed_filter_view.dart';
import 'package:rss/view/rss_feed/rss_header_view.dart';

class RssPage extends StatefulWidget {
  const RssPage._({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => RssFeedBloc.create()..add(RssFeedFetched()),
      child: const RssPage._(),
    );
  }

  @override
  State<RssPage> createState() => _RssPageState();
}

class _RssPageState extends State<RssPage> {
  Timer? _timer;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(const Duration(milliseconds: 300), () {
      List<RssFeed> rssFeeds = context.read<RssFeedBloc>().state.rssFeeds;
      context
          .read<RssFeedBloc>()
          .add(RssFeedSelectedRssChanged(rssFeed: rssFeeds[index]));
    });
  }

  void _rssFeedBlocListener(BuildContext context, RssFeedState state) {
    if (!_pageController.hasClients) {
      return;
    }

    int selectedIndex = state.rssFeeds
        .indexWhere((element) => element == state.selectedRssFeed);
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<RssFeedBloc, RssFeedState>(
          listener: _rssFeedBlocListener,
          builder: (context, state) {
            if (state.rssFeeds.isNotEmpty) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: RssHeaderView(),
                  ),
                  const RssFeedFilterView(),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: state.rssFeeds.length,
                      itemBuilder: (context, index) {
                        RssFeed rss = state.rssFeeds[index];
                        return RssFeedContentListView.create(rss);
                      },
                    ),
                  )
                ],
              );
            } else if (state.status == RssFeedStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == RssFeedStatus.error) {
              return Text("Error widget");
            } else {
              return const EmptyRssView();
            }
          },
        ),
      ),
    );
  }
}
