import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uikit/theme/theme_manager/theme_provider.dart';

import '../../../repository/user_setting_repository.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeConfiguration> {
  final UserSettingRepository userSettingRepository;

  ThemeBloc({required this.userSettingRepository})
      : super(const ThemeConfiguration(
            selectedMode: ThemeModePreference.system)) {
    on<LoadThemeRequested>(_onLoadThemeRequested);
    on<ThemeChangedRequested>(_onThemeChangedRequested);
  }

  void _onLoadThemeRequested(
      LoadThemeRequested event, Emitter<ThemeConfiguration> emit) {
    try {
      final themeMode = userSettingRepository.getCurrentThemeMode();

      emit(ThemeConfiguration(selectedMode: themeMode));
    } catch (e) {
      emit(const ThemeConfiguration(selectedMode: ThemeModePreference.system));
    }
  }

  void _onThemeChangedRequested(
      ThemeChangedRequested event, Emitter<ThemeConfiguration> emit) async {
    try {
      await userSettingRepository.setThemeMode(event.themeModePreference);
      emit(ThemeConfiguration(selectedMode: event.themeModePreference));
    } catch (e) {
      emit(const ThemeConfiguration(selectedMode: ThemeModePreference.system));
    }
  }
}
