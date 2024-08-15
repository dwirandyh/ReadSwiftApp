part of 'text_setting_bloc.dart';

@immutable
sealed class TextSettingEvent {}

final class TextSettingLoadSetting extends TextSettingEvent {}

final class TextSettingChangeTheme extends TextSettingEvent {
  final ThemeModePreference theme;

  TextSettingChangeTheme({required this.theme});
}
