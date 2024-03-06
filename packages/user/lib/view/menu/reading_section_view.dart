import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';
import 'package:user/view/menu/widget/switch_menu_item.dart';

class ReadingSectionView extends StatelessWidget {
  const ReadingSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            "Reading Experience",
            style: TextStyle(
                color: color.subtitle,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        SwitchMenuItem(
          menu: "Image Display Options",
          description:
              "Toggle the loading of images from articles based on your preferences.",
          onChanged: (value) {},
          isSelected: false,
        ),
        SwitchMenuItem(
          menu: "Continue Reading",
          description:
              "Display the last item i was in the middle of when i return to app",
          onChanged: (value) {},
          isSelected: false,
        )
      ],
    );
  }
}
