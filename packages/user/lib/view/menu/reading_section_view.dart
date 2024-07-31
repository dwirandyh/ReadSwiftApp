import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uikit/uikit.dart';
import 'package:user/bloc/menu/reading/reading_section_bloc.dart';
import 'package:user/view/menu/widget/switch_menu_item.dart';

import '../../external/user_router.dart';
import 'widget/menu_item.dart';

class ReadingSectionView extends StatelessWidget {
  const ReadingSectionView._({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => GetIt.I.get<ReadingSectionBloc>()
        ..add(ReadingSectionSettingRequested()),
      child: const ReadingSectionView._(),
    );
  }

  void _displayImageChanged(BuildContext context, bool isEnabled) {
    context
        .read<ReadingSectionBloc>()
        .add(ReadingSectionImageDisplayChanged(isEnabled: isEnabled));
  }

  void _continueReadingChanged(BuildContext context, bool isEnabled) {
    context
        .read<ReadingSectionBloc>()
        .add(ReadingSectionContinueReadingChanged(isEnabled: isEnabled));
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return BlocBuilder<ReadingSectionBloc, ReadingSectionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Text(
                "Reading Experience",
                style: TextStyle(
                    color: color.subtitle,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
            MenuItem(
              menu: "Manage Your Tag",
              onTap: () {
                UserRouter.goToManageTag(context);
              },
            ),
            MenuItem(
              menu: "Manage Your RSS",
              onTap: () {
                UserRouter.goToManageRss(context);
              },
            ),
            SwitchMenuItem(
              menu: "Image Display Options",
              description:
                  "Toggle the loading of images from articles based on your preferences.",
              onChanged: (value) {
                _displayImageChanged(context, value);
              },
              isSelected: state.isImageDisplayEnabled,
            ),
            SwitchMenuItem(
              menu: "Continue Reading",
              description:
                  "Display the last item i was in the middle of when i return to app",
              onChanged: (value) {
                _continueReadingChanged(context, value);
              },
              isSelected: state.isContinueReadingEnabled,
            )
          ],
        );
      },
    );
  }
}
