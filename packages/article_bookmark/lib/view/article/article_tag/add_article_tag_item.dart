import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class AddArticleTagItem extends StatelessWidget {
  final Tag tag;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged;

  const AddArticleTagItem(
      {super.key, required this.tag, required this.isChecked, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(
          tag.name,
          style: TextStyle(
            color: color.title,
          ),
        ),
      ],
    );
  }
}
