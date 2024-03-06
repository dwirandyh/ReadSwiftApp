import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';
import 'package:user/view/menu/widget/selection_menu_item.dart';
import 'package:user/view/menu/widget/switch_menu_item.dart';

class ThemeSectionView extends StatelessWidget {
  const ThemeSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Text(
            "App Theme",
            style: TextStyle(
                color: color.subtitle,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ),
        SelectionMenuItem(
          menu: "Theme",
          onTap: () {},
          selectedItem: "Light",
        ),
        SwitchMenuItem(
          menu: "Match system theme",
          onChanged: (value) {},
          isSelected: false,
        )
      ],
    );
  }
}
