import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uikit/uikit.dart';
import 'package:user_api/user_api.dart';

part 'text_setting_event.dart';
part 'text_setting_state.dart';

class TextSettingBloc extends Bloc<TextSettingEvent, TextSettingState> {
  final UserSettingRepositoryApi repository;

  TextSettingBloc({required this.repository})
      : super(TextSettingState.initial()) {
    on<TextSettingLoadSetting>(_onTextSettingLoadSetting);
    on<TextSettingChangeTheme>(_onTextSettingChangeTheme);
  }

  void _onTextSettingLoadSetting(
      TextSettingLoadSetting event, Emitter<TextSettingState> emit) {
    final themeKey = repository.getCurrentThemeMode();
    final currentTheme = ThemeModePreference.fromString(themeKey);
    emit(state.copyWith(theme: currentTheme));
  }

  void _onTextSettingChangeTheme(
      TextSettingChangeTheme event, Emitter<TextSettingState> emit) {
    try {
      repository.setThemeMode(event.theme.key);
      emit(state.copyWith(theme: event.theme));
    } catch (e) {
      emit(TextSettingState.initial());
    }
  }
}
