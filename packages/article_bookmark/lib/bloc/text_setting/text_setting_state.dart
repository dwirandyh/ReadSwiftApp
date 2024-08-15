part of 'text_setting_bloc.dart';

final class TextSettingState {
  final ThemeModePreference theme;
  final int fontSize;

  TextSettingState({required this.theme, required this.fontSize});

  factory TextSettingState.initial() {
    return TextSettingState(theme: ThemeModePreference.system, fontSize: 14);
  }

  TextSettingState copyWith({
    ThemeModePreference? theme,
    int? fontSize,
  }) {
    return TextSettingState(
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
