import 'package:article_bookmark/bloc/article/article_bloc.dart';
import 'package:article_bookmark/bloc/tag/tag_bloc.dart';
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
            BlocProvider<TagBloc>.value(
              value: BlocProvider.of<TagBloc>(context),
            ),
            BlocProvider<ArticleBloc>.value(
              value: BlocProvider.of<ArticleBloc>(context),
            )
          ],
          child: BlocConsumer<ArticleBloc, ArticleState>(
            listener: (context, state) {
              print(state);
            },
            builder: (context, state) {
              Article currentArticle = state.articles
                  .firstWhere((element) => element.id == article.id);
              return AddArticleTagView(
                article: currentArticle,
                articleTags: currentArticle.tags,
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    List<Tag> tags = context.read<TagBloc>().state.tags;
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
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Tag tag = tags[index];
                return AddArticleTagItem(
                  tag: tag,
                  isChecked: articleTags.contains(tag),
                  onChanged: (isChecked) {
                    if (isChecked == true) {
                      context.read<ArticleBloc>().add(ArticleTagAdded(
                          article: article.copyWith(), tag: tag.copyWith()));
                    } else {
                      context.read<ArticleBloc>().add(ArticleTagRemoved(
                          article: article.copyWith(), tag: tag.copyWith()));
                    }
                  },
                );
              },
              itemCount: tags.length,
            ),
          )
        ],
      ),
    );
  }
}
