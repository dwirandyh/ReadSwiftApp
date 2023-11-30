class ValidationHelper {
  static String? validateEmail(String email) {
    // Email validation regex
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validateIsEmpty(String value, String fieldName) {
    if (value.isEmpty) {
      return '$fieldName cannot be empty';
    }

    return null;
  }
}
