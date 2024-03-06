import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';
import 'package:user/view/menu/widget/menu_item.dart';
import 'package:user/view/menu/widget/switch_menu_item.dart';

class AboutSectionView extends StatelessWidget {
  const AboutSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            "About ReadSwift",
            style: TextStyle(
                color: color.subtitle,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        MenuItem(menu: "Term of Service", onTap: () {}),
        MenuItem(menu: "Privacy Policy", onTap: () {}),
        MenuItem(menu: "Rate on the Play Store", onTap: () {}),
      ],
    );
  }
}
