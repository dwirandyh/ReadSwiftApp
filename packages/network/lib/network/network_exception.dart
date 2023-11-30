class NetworkException implements Exception {
  final int statusCode;

  NetworkException({required this.statusCode});

  @override
  String toString() {
    // TODO: implement toString
    return "NetworkException with code: $statusCode";
  }
}
