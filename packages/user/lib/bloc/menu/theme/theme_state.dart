part of 'theme_bloc.dart';

@immutable
final class ThemeConfiguration extends Equatable {
  final ThemeModePreference selectedMode;

  const ThemeConfiguration({required this.selectedMode});

  @override
  List<Object?> get props => [selectedMode];
}
