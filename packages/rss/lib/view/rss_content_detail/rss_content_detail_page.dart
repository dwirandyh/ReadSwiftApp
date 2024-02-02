import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/bloc/rss_content_detail/rss_content_detail_bloc.dart';
import 'package:rss/model/rss_content.dart';
import 'package:rss/view/rss_content_detail/rss_content_detail_app_bar.dart';
import 'package:uikit/uikit.dart';

class RssContentDetailPage extends StatelessWidget {
  const RssContentDetailPage({super.key});

  static Widget create(int id) {
    return BlocProvider(
      create: (context) =>
          RssContentDetailBloc.create(id)..add(RssContentDetailFetched()),
      child: const RssContentDetailPage(),
    );
  }

  Widget _buildLoadingContent() {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context, RssContent rssContent) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScroller) {
          return [RssContentDetailAppBar(rssContent: rssContent)];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: WebContentViewer(
            content: WebContent(
              title: rssContent.title,
              author: rssContent.author,
              datePublished: rssContent.datePublished,
              content: rssContent.content,
              domain: rssContent.domain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFailedContent(BuildContext context) {
    final color = context.theme.uikit;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Oops! Something went wrong.",
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
              "We couldn't load the page. Please check your internet connection and try again.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            UIKitButton(
                onPressed: () {
                  context
                      .read<RssContentDetailBloc>()
                      .add(RssContentDetailFetched());
                },
                text: "Retry")
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RssContentDetailBloc, RssContentDetailState>(
      builder: (context, state) {
        switch (state) {
          case RssContentDetailLoading():
            return _buildLoadingContent();
          case RssContentDetailSuccess():
            RssContent rssContent = state.content;
            return _buildSuccessContent(context, rssContent);
          case RssContentDetailFailed():
            return _buildFailedContent(context);
        }
      },
    );
  }
}
