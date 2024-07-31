import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uikit/uikit.dart';

import '../../bloc/manage_tag/manage_tag_bloc.dart';
import 'tag_reorderable_list.dart';

class ManageTagPage extends StatelessWidget {
  const ManageTagPage({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) =>
          GetIt.I.get<ManageTagBloc>()..add(ManageTagLoadTags()),
      child: const ManageTagPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Manage Your Tags",
          style: appBarTextStyle(),
        ),
      ),
      body: SafeArea(
        child: TagReorderableList(),
      ),
    );
  }
}
