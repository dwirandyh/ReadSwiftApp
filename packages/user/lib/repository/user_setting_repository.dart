import 'package:storage/storage.dart';
import 'package:uikit/uikit.dart';
import 'package:user/external/preferences/user_preference_key.dart';

abstract class UserSettingRepository {
  ThemeModePreference getCurrentThemeMode();
  Future<void> setThemeMode(ThemeModePreference themeModePreference);

  Future<void> setImageDisplayOptions({required bool isEnabled});
  bool getImageDisplayOptions();

  Future<void> setContinueReading({required bool isEnabled});
  bool getContinueReading();
}

class UserSettingRepositoryImpl implements UserSettingRepository {
  final SharedPreferenceService preferenceService;

  UserSettingRepositoryImpl({required this.preferenceService});

  @override
  ThemeModePreference getCurrentThemeMode() {
    final String mode =
        preferenceService.getValue(UserPreferenceKeys.themeMode);

    if (mode == ThemeModePreference.light.key) {
      return ThemeModePreference.light;
    } else if (mode == ThemeModePreference.dark.key) {
      return ThemeModePreference.dark;
    } else {
      return ThemeModePreference.system;
    }
  }

  @override
  Future<void> setThemeMode(ThemeModePreference themeModePreference) async {
    await preferenceService.setValue(
        UserPreferenceKeys.themeMode, themeModePreference.key);
  }

  @override
  bool getContinueReading() {
    return preferenceService.getValue(UserPreferenceKeys.continueReading);
  }

  @override
  bool getImageDisplayOptions() {
    return preferenceService.getValue(UserPreferenceKeys.displayImage);
  }

  @override
  Future<void> setContinueReading({required bool isEnabled}) async {
    await preferenceService.setValue(
        UserPreferenceKeys.continueReading, isEnabled);
  }

  @override
  Future<void> setImageDisplayOptions({required bool isEnabled}) async {
    await preferenceService.setValue(
        UserPreferenceKeys.displayImage, isEnabled);
  }
}
