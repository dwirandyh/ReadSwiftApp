import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/view/manage_tag/tag_list_item.dart';

import '../../bloc/manage_tag/manage_tag_bloc.dart';
import '../widget/reorderable_proxy_decator.dart';

class TagReorderableList extends StatelessWidget {
  const TagReorderableList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageTagBloc, ManageTagState>(
      builder: (context, state) {
        return ReorderableListView.builder(
          proxyDecorator: (child, index, animation) {
            return ReorderableProxyDecorator(
              animation: animation,
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final tag = state.tags[index];
            return TagListItem(
              key: Key(tag.id.toString()),
              tag: state.tags[index],
            );
          },
          itemCount: state.tags.length,
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            context.read<ManageTagBloc>().add(
                ManageTagUpdateOrder(oldIndex: oldIndex, newIndex: newIndex));
          },
        );
      },
    );
  }
}
