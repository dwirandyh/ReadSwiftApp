import 'package:storage/storage.dart';
import 'package:uikit/uikit.dart';
import 'package:user/external/preferences/user_preference_key.dart';

abstract class UserSettingRepository {
  ThemeModePreference getCurrentThemeMode();
  Future<void> setThemeMode(ThemeModePreference themeModePreference);
}

class UserSettingRepositoryImpl implements UserSettingRepository {
  final SharedPreferenceService preferenceService;

  UserSettingRepositoryImpl({required this.preferenceService});

  @override
  ThemeModePreference getCurrentThemeMode() {
    final String mode =
        preferenceService.getValue(UserPreferenceKeys.themeMode) ??
            ThemeModePreference.system.key;

    if (mode == ThemeModePreference.light.key) {
      return ThemeModePreference.light;
    } else if (mode == ThemeModePreference.light.key) {
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
}
