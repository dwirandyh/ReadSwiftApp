import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/bloc/manage_rss/manage_rss_bloc.dart';
import 'package:user/view/manage_rss/rss_list_item.dart';
import 'package:user/view/widget/reorderable_proxy_decator.dart';

class RssReoderableList extends StatelessWidget {
  const RssReoderableList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageRssBloc, ManageRssState>(
      builder: (context, state) {
        return ReorderableListView.builder(
          proxyDecorator: (child, index, animation) {
            return ReorderableProxyDecorator(
              animation: animation,
              child: child,
            );
          },
          itemBuilder: (context, index) {
            final rss = state.rss[index];
            return RssListItem(
              key: Key(rss.id.toString()),
              rss: rss,
            );
          },
          itemCount: state.rss.length,
          onReorder: (oldIndex, newIndex) {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            context.read<ManageRssBloc>().add(
                ManageRssUpdateOrder(oldIndex: oldIndex, newIndex: newIndex));
          },
        );
      },
    );
  }
}
