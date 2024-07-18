import 'package:article_bookmark_api/article_bookmark_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

import '../../bloc/manage_tag/manage_tag_bloc.dart';

class TagListItem extends StatefulWidget {
  final Tag tag;

  const TagListItem({super.key, required this.tag});

  @override
  State<TagListItem> createState() => _TagListItemState();
}

class _TagListItemState extends State<TagListItem> {
  final FocusNode _nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.tag.name;
  }

  void _deleteTagTapped() {
    context.read<ManageTagBloc>().add(ManageTagDelete(id: widget.tag.id));
  }

  void _renameTapped() {
    _nameController.text = widget.tag.name;
    setState(() {
      _isEditMode = true;
    });

    _nameFocusNode.requestFocus();
  }

  void _saveRenameTapped() async {
    final name = _nameController.text;
    context
        .read<ManageTagBloc>()
        .add(ManageTagRename(id: widget.tag.id, newName: name));

    setState(() {
      _isEditMode = false;
    });
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameController.dispose();
    super.dispose();
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
      child: _isEditMode ? editForm() : itemView(),
    );
  }

  Widget itemView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.tag.name,
          style: const TextStyle(fontSize: 14, letterSpacing: 0.5),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'Delete':
                _deleteTagTapped();
                break;
              case 'Rename':
                _renameTapped();
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
    );
  }

  Widget editForm() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            controller: _nameController,
            focusNode: _nameFocusNode,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 14, letterSpacing: 0.5),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
          ),
          onPressed: () {
            setState(() {
              _isEditMode = false;
            });
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.save,
          ),
          onPressed: () {
            _saveRenameTapped();
          },
        ),
      ],
    );
  }
}
