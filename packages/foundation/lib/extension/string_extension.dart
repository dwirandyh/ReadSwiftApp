extension StringExtension on String {
  bool isValidURL() {
    final RegExp urlRegExp = RegExp(
      r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$",
      caseSensitive: false,
      multiLine: false,
    );

    return urlRegExp.hasMatch(this);
  }
}
