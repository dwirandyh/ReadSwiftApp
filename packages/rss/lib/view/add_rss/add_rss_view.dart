import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';

class AddRssView extends StatelessWidget {
  const AddRssView({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (bottomSheetContext) {
        return AddRssView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Add an New RSS Feed",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color.title,
            ),
          ),
          Text(
            "Never miss an update. Stay in the know with RSS feeds",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: color.caption,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                UIKitTextField(
                  title: "Name",
                  placeholder: "Enter RSS Name",
                ),
                SizedBox(
                  height: 8,
                ),
                UIKitTextField(
                  title: "RSS URL",
                  placeholder: "Enter RSS URL",
                  rules: [
                    ValidationRule.required,
                    ValidationRule.url,
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          UIKitButton(
            onPressed: () {},
            text: "Add an RSS",
          )
        ],
      ),
    );
  }
}
