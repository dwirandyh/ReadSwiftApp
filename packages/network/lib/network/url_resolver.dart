class URLResolver {
  const URLResolver({required this.path});

  final String path;
  // static const String baseURL = "http://10.0.2.2:80";
  static const String baseURL = "http://localhost:80";

  Uri fullURI() {
    return Uri.parse("${URLResolver.baseURL}/api/$path");
  }
}
