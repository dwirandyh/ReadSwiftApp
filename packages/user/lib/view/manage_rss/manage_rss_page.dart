import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uikit/uikit.dart';
import 'package:user/bloc/manage_rss/manage_rss_bloc.dart';

import 'rss_reoderable_list.dart';

class ManageRssPage extends StatelessWidget {
  const ManageRssPage({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) =>
          GetIt.I.get<ManageRssBloc>()..add(ManageRssLoadRss()),
      child: const ManageRssPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Your RSS",
          style: appBarTextStyle(),
        ),
      ),
      body: SafeArea(
        child: RssReoderableList(),
      ),
    );
  }
}
