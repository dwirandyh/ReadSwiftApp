import 'package:article_bookmark/view/tag/tag_item.dart';
import 'package:flutter/material.dart';

class TagFilterView extends StatelessWidget {
  const TagFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
          height: 32,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 8),
              const TagItem(tag: "All"),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TagItem(tag: "Swift"),
                    TagItem(tag: "g"),
                    TagItem(tag: "SwiftUI"),
                    TagItem(tag: "Flutter"),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
