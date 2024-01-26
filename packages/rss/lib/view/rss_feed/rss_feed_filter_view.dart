import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/bloc/rss_feed/rss_feed_bloc.dart';
import 'package:rss/model/rss_feed.dart';
import 'package:rss/view/add_rss/add_rss_view.dart';
import 'package:uikit/uikit.dart';

class RssFeedFilterView extends StatelessWidget {
  const RssFeedFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RssFeedBloc, RssFeedState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(Icons.add, color: Colors.grey),
                      onPressed: () {
                        AddRssView.show(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  UIChip(
                    text: "All",
                    isActive: state.selectedRssFeed == null,
                    onTap: () {
                      context
                          .read<RssFeedBloc>()
                          .add(const RssFeedSelectedRssChanged());
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.rssFeeds.length,
                      itemBuilder: (context, index) {
                        RssFeed rss = state.rssFeeds[index];
                        return UIChip(
                          text: rss.name,
                          isActive: (rss == state.selectedRssFeed),
                          onTap: () {
                            context
                                .read<RssFeedBloc>()
                                .add(RssFeedSelectedRssChanged(rssFeed: rss));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider()
          ],
        );
      },
    );
  }
}
