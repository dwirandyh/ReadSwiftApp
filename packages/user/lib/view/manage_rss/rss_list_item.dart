import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss_api/rss_api.dart';
import 'package:uikit/uikit.dart';
import 'package:user/bloc/manage_rss/manage_rss_bloc.dart';
import 'package:user/view/manage_rss/edit_rss/edit_rss_view.dart';

class RssListItem extends StatelessWidget {
  final RssFeed rss;

  const RssListItem({super.key, required this.rss});

  void _deleteRss(BuildContext context) {
    context.read<ManageRssBloc>().add(ManageRssDeleteRss(id: rss.id));
  }

  void _editRss(BuildContext context) {
    EditRssView.show(context, rss);
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: color.divider, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                rss.name,
                style: TextStyle(fontSize: 16, color: color.title),
              ),
              Text(
                rss.url,
                style: TextStyle(fontSize: 12, color: color.caption),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Edit':
                  _editRss(context);
                  break;
                case 'Delete':
                  _deleteRss(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Delete'}.map((String choice) {
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
