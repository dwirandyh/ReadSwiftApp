import 'package:storage/storage.dart';
import 'package:user/external/preferences/user_preference_key.dart';
import 'package:user_api/user_api.dart';

class UserSettingRepositoryImpl implements UserSettingRepositoryApi {
  final SharedPreferenceService preferenceService;

  UserSettingRepositoryImpl({required this.preferenceService});

  @override
  String getCurrentThemeMode() {
    final String mode =
        preferenceService.getValue(UserPreferenceKeys.themeMode);
    return mode;
  }

  @override
  Future<void> setThemeMode(String themeModePreference) async {
    await preferenceService.setValue(UserPreferenceKeys.themeMode, String);
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
