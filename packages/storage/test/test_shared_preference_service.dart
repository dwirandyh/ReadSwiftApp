import 'package:flutter_test/flutter_test.dart';
import 'package:storage/preference_key.dart';
import 'package:storage/shared_preference_service.dart';

import 'fake_shared_preferences.dart';

// Define extension for preference keys
extension TestPreferenceKeys on PreferenceKey {
  static const PreferenceKey<String> userName =
      PreferenceKey<String>('userName', defaultValue: 'Guest');
  static const PreferenceKey<int> userAge =
      PreferenceKey<int>('userAge', defaultValue: 18);
  static const PreferenceKey<bool> isLoggedIn =
      PreferenceKey<bool>('isLoggedIn', defaultValue: false);

  // Define a key with a nullable default value
  static const PreferenceKey<String?> userBio =
      PreferenceKey<String?>('userBio', defaultValue: null);
}

void main() {
  late SharedPreferenceServiceImpl sharedPreferenceService;
  late FakeSharedPreferences fakeSharedPreferences;

  setUp(() async {
    fakeSharedPreferences = FakeSharedPreferences();

    sharedPreferenceService = SharedPreferenceServiceImpl();
    await sharedPreferenceService.init(fakeSharedPreferences);
    sharedPreferenceService.clear();
  });

  group('SharedPreferencesManager', () {
    test('should save and retrieve a string value', () async {
      await sharedPreferenceService.setValue(
          TestPreferenceKeys.userName, 'John Doe');

      final result =
          sharedPreferenceService.getValue(TestPreferenceKeys.userName);

      expect(result, 'John Doe');
    });

    test('should save and retrieve an int value', () async {
      await sharedPreferenceService.setValue(TestPreferenceKeys.userAge, 30);

      final result =
          sharedPreferenceService.getValue(TestPreferenceKeys.userAge);

      expect(result, 30);
    });

    test('should save and retrieve a bool value', () async {
      await sharedPreferenceService.setValue(
          TestPreferenceKeys.isLoggedIn, true);

      final result =
          sharedPreferenceService.getValue(TestPreferenceKeys.isLoggedIn);

      expect(result, true);
    });

    test('should retrieve a nullable default value', () async {
      final result =
          sharedPreferenceService.getValue(TestPreferenceKeys.userBio);

      expect(result, null);
    });

    test('should retrieve a default value', () async {
      final result =
          sharedPreferenceService.getValue(TestPreferenceKeys.userName);

      expect(result, 'Guest');
    });

    test('should remove a value and return default value if any', () async {
      await sharedPreferenceService.remove(TestPreferenceKeys.userName);

      final result =
          sharedPreferenceService.getValue(TestPreferenceKeys.userName);

      expect(result,
          'Guest'); // Check that default value is retrieved after removal
    });
  });
}
