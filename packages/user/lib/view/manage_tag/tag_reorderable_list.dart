import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

import '../../bloc/manage_tag/manage_tag_bloc.dart';

class TagReorderableList extends StatelessWidget {
  const TagReorderableList({super.key});

  void _deleteTag(BuildContext context, Tag tag) {
    context.read<ManageTagBloc>().add(ManageTagDeleted(id: tag.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageTagBloc, ManageTagState>(
      builder: (context, state) {
        return ReorderableListView.builder(
          proxyDecorator: (child, index, animation) {
            return proxyDecorator(context, child, index, animation);
          },
          itemBuilder: (context, index) {
            return listItem(context: context, tag: state.tags[index]);
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

  Widget listItem({required BuildContext context, required Tag tag}) {
    final color = context.theme.uikit;
    return Container(
      key: Key(tag.id.toString()),
      padding: const EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: color.divider, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(tag.name),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Delete':
                  _deleteTag(context, tag);
                  break;
                case 'Rename':
                  // _renameItem(item);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Delete', 'Rename'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }
}
