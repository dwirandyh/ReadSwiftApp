import 'package:dio/dio.dart';

class AuthenticationInterceptor extends QueuedInterceptor {
  final String tokenType;
  final String token;

  AuthenticationInterceptor._({required this.tokenType, required this.token});

  static AuthenticationInterceptor? instance;

  factory AuthenticationInterceptor(
      {required String tokenType, required String token}) {
    return instance ??=
        AuthenticationInterceptor._(tokenType: tokenType, token: token);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = '$tokenType $token';
    super.onRequest(options, handler);
  }
}
