import 'package:article_bookmark/bloc/article/add_article_tag/add_article_tag_bloc.dart';
import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/model/article.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/view/article/article_tag/add_article_tag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class AddArticleTagView extends StatelessWidget {
  final List<Tag> articleTags;
  final Article article;

  const AddArticleTagView(
      {super.key, required this.article, required this.articleTags});

  static void show(
      {required BuildContext context,
      required Article article,
      required List<Tag> articleTags}) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AddArticleTagBloc>.value(
              value: BlocProvider.of<AddArticleTagBloc>(context)
                ..add(AddArticleTagFetched()),
            ),
            BlocProvider<ArticleBloc>.value(
              value: BlocProvider.of<ArticleBloc>(context),
            ),
          ],
          child: BlocConsumer<AddArticleTagBloc, AddArticleTagState>(
            listener: (context, state) {
              if (state is AddArticleTagRemoved) {
                context.read<ArticleBloc>().add(ArticleTagRemoved(
                    article: state.article, tag: state.removedTag));
              }
            },
            builder: (context, state) {
              return AddArticleTagView(
                article: state.article,
                articleTags: state.article.tags,
              );
            },
          ),
        );
      },
    );
  }

  Widget _tagList(BuildContext context, List<Tag> tags) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Tag tag = tags[index];
        return AddArticleTagItem(
          tag: tag,
          isChecked:
              articleTags.isNotEmpty ? article.tags.contains(tag) : false,
          onChanged: (isChecked) {
            if (isChecked == true) {
              context.read<AddArticleTagBloc>().add(
                    AddArticleTagAddRequested(
                      article: article.copyWith(),
                      tag: tag.copyWith(),
                    ),
                  );
            } else {
              context.read<AddArticleTagBloc>().add(
                    AddArticleTagRemoveRequested(
                      article: article.copyWith(),
                      tag: tag.copyWith(),
                    ),
                  );
            }
          },
        );
      },
      itemCount: tags.length,
    );
  }

  Widget _loading() {
    return const SizedBox(
      width: 100,
      height: 300,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    List<Tag> allTags = context.read<AddArticleTagBloc>().state.allTags;
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 8),
            child: Row(
              children: [
                Text(
                  "Save to",
                  style: TextStyle(
                      color: color.title,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                UIKitButton(
                  onPressed: () {
                    context.pop();
                  },
                  text: "Done",
                  type: UIKitButtonType.text,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: allTags.isNotEmpty ? _tagList(context, allTags) : _loading(),
          )
        ],
      ),
    );
  }
}
