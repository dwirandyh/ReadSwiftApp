part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class LoadThemeRequested extends ThemeEvent {}

class ThemeChangedRequested extends ThemeEvent {
  final ThemeModePreference themeModePreference;

  ThemeChangedRequested({required this.themeModePreference});
}
