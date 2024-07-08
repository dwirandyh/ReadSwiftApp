import 'package:storage/storage.dart';

extension UserPreferenceKeys on PreferenceKey {
  static const PreferenceKey<String> themeMode = PreferenceKey<String>(
    'theme_mode',
    defaultValue: 'system',
  );

  static const PreferenceKey<bool> displayImage = PreferenceKey<bool>(
    'display_image',
    defaultValue: true,
  );

  static const PreferenceKey<bool> continueReading = PreferenceKey<bool>(
    'continue_reading',
    defaultValue: true,
  );
}
