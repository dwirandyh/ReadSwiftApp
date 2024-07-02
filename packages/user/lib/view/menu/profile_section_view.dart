import 'package:authentication_api/authentication_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uikit/uikit.dart';
import 'package:user/external/user_router.dart';
import 'package:user/view/menu/widget/menu_divider.dart';
import 'package:user/view/menu/widget/menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authentication_api/authentication_api.dart';

class ProfileSectionView extends StatelessWidget {
  const ProfileSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<AuthenticationBlocAPI, AuthenticationState>(
            builder: (context, state) {
              return Row(
                children: [
                  if (state.user?.avatar != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: CachedNetworkImage(
                        imageUrl: state.user!.avatar!,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) =>
                            _userPlaceholder(),
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user?.name ?? "",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: color.title),
                      ),
                      Text(
                        state.user?.email ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: color.subtitle,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuItem(
                menu: "Change Password",
                onTap: () {
                  UserRouter.goToChangePassword(context);
                }),
            MenuItem(menu: "Delete Account", onTap: () {}),
          ],
        ),
        MenuDivider(context: context),
        InkWell(
          onTap: () {
            context
                .read<AuthenticationBlocAPI>()
                .add(AuthenticationLogoutRequested());
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Text(
              "LOG OUT",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: color.danger, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        MenuDivider(context: context),
      ],
    );
  }

  Widget _userPlaceholder() {
    return SizedBox(
      width: 60,
      height: 60,
      child: Image.asset(
        "assets/ic_user_placeholder.png",
        package: "user",
      ),
    );
  }
}
