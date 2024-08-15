import 'package:article_bookmark/bloc/text_setting/text_setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';

class ModeSelectionWidget extends StatefulWidget {
  @override
  _ModeSelectionWidgetState createState() => _ModeSelectionWidgetState();
}

class _ModeSelectionWidgetState extends State<ModeSelectionWidget> {
  int _selectedMode = 0;

  void _changeThemeMode() {
    ThemeModePreference themeModePreference;
    if (_selectedMode == 0) {
      themeModePreference = ThemeModePreference.light;
    } else if (_selectedMode == 1) {
      themeModePreference = ThemeModePreference.system;
    } else {
      themeModePreference = ThemeModePreference.dark;
    }

    context
        .read<TextSettingBloc>()
        .add(TextSettingChangeTheme(theme: themeModePreference));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildModeButton(Icons.wb_sunny, 0),
              _buildModeButton(Icons.brightness_auto, 1),
              _buildModeButton(Icons.nights_stay, 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeButton(IconData icon, int index) {
    final color = context.theme.uikit;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = index;
          _changeThemeMode();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedMode == index ? color.accent : Colors.grey[800],
          boxShadow: _selectedMode == index
              ? [BoxShadow(color: color.accent, blurRadius: 10)]
              : [],
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
