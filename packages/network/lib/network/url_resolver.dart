class URLResolver {
  const URLResolver({required this.path});

  final String path;
  // for android simulator only
  static const String baseURL = "http://10.0.2.2:80";
  // static const String baseURL = "http://localhost:80";

  String fullURI() {
    return "${URLResolver.baseURL}/api/$path";
  }
}
