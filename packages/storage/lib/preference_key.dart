class PreferenceKey<T> {
  final String key;
  final T defaultValue;

  const PreferenceKey(this.key, {required this.defaultValue});
}

extension AppPreferenceKeys on PreferenceKey {
  static const PreferenceKey<String> themeMode =
      PreferenceKey<String>('theme_mode', defaultValue: 'system');
}
