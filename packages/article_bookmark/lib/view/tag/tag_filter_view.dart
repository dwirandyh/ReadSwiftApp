import 'package:article_bookmark/bloc/tag/tag_bloc.dart';
import 'package:article_bookmark/model/tag.dart';
import 'package:article_bookmark/view/tag/tag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagFilterView extends StatelessWidget {
  const TagFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TagBloc, TagState>(
      builder: (context, state) {
        Tag selectedTag = state.selectedTag;
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TagItem(
                    tag: "All",
                    isActive: selectedTag == Tag.all(),
                    onTap: () {
                      context
                          .read<TagBloc>()
                          .add(SelectedTagChanged(tag: Tag.all()));
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: BlocBuilder<TagBloc, TagState>(
                      builder: (context, state) {
                        if (state.status == TagStatus.success) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Tag tag = state.tags[index];
                              return TagItem(
                                tag: tag.name,
                                isActive: (tag == selectedTag),
                                onTap: () {
                                  context
                                      .read<TagBloc>()
                                      .add(SelectedTagChanged(tag: tag));
                                },
                              );
                            },
                            itemCount: state.tags.length,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider()
          ],
        );
      },
    );
  }
}
