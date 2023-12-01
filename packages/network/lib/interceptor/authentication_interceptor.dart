import 'package:dio/dio.dart';

class AuthenticationInterceptor extends Interceptor {
  final String tokenType;
  final String token;

  AuthenticationInterceptor({required this.tokenType, required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = '$tokenType $token';
    super.onRequest(options, handler);
  }
}
