class URLResolver {
  final String path;
  final Map<String, dynamic>? parameters;

  const URLResolver({required this.path, this.parameters});

  // for android simulator only
  static const String baseURL = "http://10.0.2.2:80";
  // static const String baseURL = "http://localhost:80";

  String fullURI() {
    String url = "${URLResolver.baseURL}/api/$path";

    if (parameters != null && parameters!.isNotEmpty) {
      // Convert parameters to query parameters
      String queryParams = parameters!.entries
          .map((entry) =>
              "${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}")
          .join("&");

      // Append query parameters to the URL
      url += "?$queryParams";
    }

    return url;
  }
}
