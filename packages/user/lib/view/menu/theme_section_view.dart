import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uikit/uikit.dart';
import 'package:user/view/menu/theme_selection_view.dart';
import 'package:user/view/menu/widget/selection_menu_item.dart';
import 'package:user/view/menu/widget/switch_menu_item.dart';

import '../../bloc/menu/theme/theme_bloc.dart';

class ThemeSectionView extends StatelessWidget {
  const ThemeSectionView._({super.key});

  static Widget create() {
    return BlocProvider(
      create: (context) => GetIt.I.get<ThemeBloc>()..add(LoadThemeRequested()),
      child: const ThemeSectionView._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = context.theme.uikit;
    return BlocListener<ThemeBloc, ThemeConfiguration>(
      listener: (context, state) {
        ThemeProvider.of(context).updateTheme(state.selectedMode);
      },
      child: BlocBuilder<ThemeBloc, ThemeConfiguration>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
                onTap: () {
                  final String selectedTheme =
                      _getThemeName(context, state.selectedMode);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    builder: (modalContext) {
                      return ThemeSelectionView(
                        selectedTheme: selectedTheme,
                        onThemeSelected: (String theme) {
                          final selectedTheme = theme == "Light"
                              ? ThemeModePreference.light
                              : ThemeModePreference.dark;
                          context.read<ThemeBloc>().add(ThemeChangedRequested(
                              themeModePreference: selectedTheme));
                        },
                      );
                    },
                  );
                },
                selectedItem: _getThemeName(context, state.selectedMode),
              ),
              SwitchMenuItem(
                  menu: "Match system theme",
                  onChanged: (value) {
                    _onMatchSystemThemeChanged(context, value);
                  },
                  isSelected: state.selectedMode == ThemeModePreference.system)
            ],
          );
        },
      ),
    );
  }

  String _getThemeName(BuildContext context, ThemeModePreference mode) {
    switch (mode) {
      case ThemeModePreference.light:
        return "Light";
      case ThemeModePreference.dark:
        return "Dark";
      case ThemeModePreference.system:
        return MediaQuery.platformBrightnessOf(context) == Brightness.dark
            ? "Dark"
            : "Light";
    }
  }

  void _onMatchSystemThemeChanged(BuildContext context, bool value) {
    ThemeModePreference modePreference;
    if (value) {
      modePreference = ThemeModePreference.system;
    } else {
      modePreference = context.isPlatformDarkMode
          ? ThemeModePreference.dark
          : ThemeModePreference.light;
    }

    context
        .read<ThemeBloc>()
        .add(ThemeChangedRequested(themeModePreference: modePreference));
  }
}
