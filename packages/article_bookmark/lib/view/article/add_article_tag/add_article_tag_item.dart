import 'package:article_bookmark/model/tag.dart';
import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class AddArticleTagItem extends StatelessWidget {
  final Tag tag;
  final bool isChecked;
  const AddArticleTagItem(
      {super.key, required this.tag, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {},
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
