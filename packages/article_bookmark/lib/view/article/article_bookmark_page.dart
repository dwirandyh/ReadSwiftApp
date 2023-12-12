import 'dart:async';

import 'package:article_bookmark/bloc/tag/tag_bloc.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/repository/tag_repository.dart';
import 'package:article_bookmark/view/article/article_bookmark_header.dart';
import 'package:article_bookmark/view/article/article_per_tag_section.dart';
import 'package:article_bookmark/view/tag/tag_filter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';
import 'package:uikit/theme/uikit_theme_color.dart';

class ArticleBookmarkPage extends StatefulWidget {
  const ArticleBookmarkPage._({super.key});

  @override
  State<ArticleBookmarkPage> createState() => _ArticleBookmarkPageState();

  static Widget create() {
    return BlocProvider(
      create: (context) => TagBloc(
        tagRepository: TagRepositoryImpl(
          client: HttpNetwork.client,
        ),
      )..add(TagFetched()),
      child: const ArticleBookmarkPage._(),
    );
  }
}

class _ArticleBookmarkPageState extends State<ArticleBookmarkPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  Tag? selectedTag;
  Timer? _timer;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final colors = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: ArticleBookmarkHeader(),
            ),
            const SizedBox(
              height: 16,
            ),
            TagFilterView(),
            Expanded(
              child: BlocConsumer<TagBloc, TagState>(
                listener: (context, state) {
                  if (!_pageController.hasClients) {
                    return;
                  }

                  Tag? selectedTag = state.selectedTag;
                  if (selectedTag != Tag.all()) {
                    int selectedIndex = state.tags
                        .indexWhere((element) => element == selectedTag);
                    _pageController.jumpToPage(
                      selectedIndex + 1,
                    );
                  } else {
                    _pageController.jumpToPage(0);
                  }
                },
                builder: (context, state) {
                  return BlocBuilder<TagBloc, TagState>(
                    builder: (context, state) {
                      if (state.status == TagStatus.success) {
                        return PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            if (_timer != null) {
                              _timer?.cancel();
                            }

                            _timer =
                                Timer(const Duration(milliseconds: 300), () {
                              if (index == 0) {
                                context
                                    .read<TagBloc>()
                                    .add(SelectedTagChanged(tag: Tag.all()));
                              } else {
                                context.read<TagBloc>().add(SelectedTagChanged(
                                    tag: state.tags[index - 1]));
                              }
                            });
                          },
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return ArticlePerTagSection.create(null);
                            } else {
                              return ArticlePerTagSection.create(
                                  state.tags[index - 1]);
                            }
                          },
                          itemCount: state.tags.length + 1,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
