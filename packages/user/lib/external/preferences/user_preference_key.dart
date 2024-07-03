import 'package:storage/storage.dart';

extension UserPreferenceKeys on PreferenceKey {
  static const PreferenceKey<String> themeMode = PreferenceKey<String>(
    'theme_mode',
    defaultValue: 'system',
  );
}
