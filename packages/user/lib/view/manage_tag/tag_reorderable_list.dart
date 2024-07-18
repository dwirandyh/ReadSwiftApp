import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';
import 'package:user/view/manage_tag/tag_list_item.dart';

import '../../bloc/manage_tag/manage_tag_bloc.dart';

class TagReorderableList extends StatelessWidget {
  const TagReorderableList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageTagBloc, ManageTagState>(
      builder: (context, state) {
        return ReorderableListView.builder(
          proxyDecorator: (child, index, animation) {
            return proxyDecorator(context, child, index, animation);
          },
          itemBuilder: (context, index) {
            final tag = state.tags[index];
            return TagListItem(
              key: Key(tag.id.toString()),
              tag: state.tags[index],
            );
          },
          itemCount: state.tags.length,
          onReorder: (oldIndex, newIndex) {},
        );
      },
    );
  }

  Widget proxyDecorator(BuildContext context, Widget child, int index,
      Animation<double> animation) {
    final color = context.theme.uikit;
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Material(
          color: color.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: UIKitThemeColor.dark.accent),
                borderRadius: BorderRadius.circular(4),
              ),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
