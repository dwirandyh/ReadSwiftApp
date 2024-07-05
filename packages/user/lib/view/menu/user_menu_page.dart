import 'package:flutter/material.dart';
import 'package:uikit/uikit.dart';
import 'package:user/view/menu/about_section_view.dart';
import 'package:user/view/menu/profile_section_view.dart';
import 'package:user/view/menu/reading_section_view.dart';
import 'package:user/view/menu/theme_section_view.dart';
import 'package:user/view/menu/widget/menu_divider.dart';

class UserMenuPage extends StatefulWidget {
  const UserMenuPage._({super.key});

  static Widget create() {
    return const UserMenuPage._();
  }

  @override
  State<UserMenuPage> createState() => _UserMenuPageState();
}

class _UserMenuPageState extends State<UserMenuPage>
    with AutomaticKeepAliveClientMixin<UserMenuPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: colors.title,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileSectionView(),
                    ThemeSectionView.create(),
                    MenuDivider(context: context),
                    const ReadingSectionView(),
                    MenuDivider(context: context),
                    const AboutSectionView()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
