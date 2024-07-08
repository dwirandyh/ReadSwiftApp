import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
  Future<PackageInfo> _loadPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileSectionView(),
                    ThemeSectionView.create(),
                    MenuDivider(context: context),
                    ReadingSectionView.create(),
                    MenuDivider(context: context),
                    const AboutSectionView(),
                    _appVersion(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _appVersion(BuildContext context) {
    final color = context.theme.uikit;
    return FutureBuilder(
      future: _loadPackageInfo(),
      builder: (context, snapshot) {
        final packageInfo = snapshot.data as PackageInfo?;
        final version = packageInfo?.version ?? "";
        final buildNumber = packageInfo?.buildNumber ?? "";
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Version $version ($buildNumber)",
            style: TextStyle(
              color: color.subtitle,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
