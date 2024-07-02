import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uikit/uikit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:user/view/menu/about_section_view.dart';
import 'package:user/view/menu/profile_section_view.dart';
import 'package:user/view/menu/reading_section_view.dart';
import 'package:user/view/menu/theme_section_view.dart';
import 'package:user/view/menu/widget/menu_divider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class UserMenuPage extends StatelessWidget {
  const UserMenuPage._({super.key});

  static Widget create() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBlocAPI>(
          create: (context) => GetIt.I.get<AuthenticationBlocAPI>(),
        ),
      ],
      child: const UserMenuPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<UIKitThemeColor>()!;
    return Scaffold(
      backgroundColor: colors.background,
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
                    const ThemeSectionView(),
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
