import 'package:article_bookmark/bloc/tag/tag_bloc.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/view/article/add_article_tag/add_article_tag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class AddArticleTagView extends StatelessWidget {
  final List<Tag> articleTags;
  const AddArticleTagView({super.key, required this.articleTags});

  static void show(
      {required BuildContext context, required List<Tag> articleTags}) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) {
        return BlocProvider<TagBloc>.value(
          value: BlocProvider.of<TagBloc>(context),
          child: AddArticleTagView(
            articleTags: articleTags,
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
