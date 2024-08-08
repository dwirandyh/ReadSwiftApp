abstract class UserSettingRepositoryApi {
  String getCurrentThemeMode();
  Future<void> setThemeMode(String themeModePreference);

  Future<void> setImageDisplayOptions({required bool isEnabled});
  bool getImageDisplayOptions();

  Future<void> setContinueReading({required bool isEnabled});
  bool getContinueReading();
}
