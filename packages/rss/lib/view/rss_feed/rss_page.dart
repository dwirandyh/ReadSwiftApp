import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rss/bloc/rss_feed/rss_feed_bloc.dart';
import 'package:rss/view/rss_feed/empty_rss_view.dart';
import 'package:rss/view/rss_feed/rss_feed_content_list_view.dart';
import 'package:rss/view/rss_feed/rss_feed_filter_view.dart';
import 'package:rss/view/rss_feed/rss_header_view.dart';
import 'package:rss_api/rss_api.dart';

class RssPage extends StatefulWidget {
  const RssPage._({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) =>
          RssFeedBloc(rssRepository: GetIt.I.get())..add(RssFeedFetched()),
      child: const RssPage._(),
    );
  }

  @override
  State<RssPage> createState() => _RssPageState();
}

class _RssPageState extends State<RssPage>
    with AutomaticKeepAliveClientMixin<RssPage> {
  Timer? _timer;
  final PageController _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

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
      if (index == 0) {
        context.read<RssFeedBloc>().add(const RssFeedSelectedRssChanged());
      } else {
        List<RssFeed> rssFeeds = context.read<RssFeedBloc>().state.rssFeeds;
        context
            .read<RssFeedBloc>()
            .add(RssFeedSelectedRssChanged(rssFeed: rssFeeds[index - 1]));
      }
    });
  }

  void _rssFeedBlocListener(BuildContext context, RssFeedState state) {
    if (!_pageController.hasClients) {
      return;
    }

    if (state.selectedRssFeed != null) {
      int selectedIndex = state.rssFeeds
          .indexWhere((element) => element == state.selectedRssFeed);
      _pageController.jumpToPage(selectedIndex + 1);
    } else {
      _pageController.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                      itemCount: state.rssFeeds.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return RssFeedContentListView.create(null);
                        } else {
                          RssFeed rss = state.rssFeeds[index - 1];
                          return RssFeedContentListView.create(rss);
                        }
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
