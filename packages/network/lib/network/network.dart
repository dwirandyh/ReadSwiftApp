import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:network/network/network_exception.dart';
import 'package:network/network/url_resolver.dart';

abstract interface class HttpNetwork {
  static final HttpNetwork _instance = HttpNetworkImpl(
    client: Dio(
      BaseOptions(
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    ),
  );

  HttpNetwork._();

  static HttpNetwork client = _instance;

  void addInterceptor(Interceptor interceptor);
  void removeInterceptor(Interceptor interceptor);

  Future<Map<String, dynamic>> get(URLResolver url);

  Future<Map<String, dynamic>> post(URLResolver url, Map<String, dynamic> body);
}

class HttpNetworkImpl extends HttpNetwork {
  final Dio client;

  HttpNetworkImpl({required this.client}) : super._();

  @override
  void addInterceptor(Interceptor interceptor) {
    client.interceptors.add(interceptor);
  }

  @override
  void removeInterceptor(Interceptor interceptor) {
    client.interceptors.remove(interceptor);
  }

  @override
  Future<Map<String, dynamic>> get(URLResolver url) async {
    // var response = await client.get(url.fullURI(), headers: headers);
    var response = await client.get(url.fullURI());

    int? statusCode = response.statusCode;
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return response.data;
    } else {
      throw NetworkException(statusCode: statusCode ?? 0);
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      URLResolver url, Map<String, dynamic> body) async {
    var encodedBody = convert.jsonEncode(body);
    var response = await client.post(url.fullURI(), data: encodedBody);

    int? statusCode = response.statusCode;
    if (statusCode != null && statusCode >= 200 && statusCode < 300) {
      return response.data;
    } else {
      throw NetworkException(statusCode: statusCode ?? 0);
    }
  }
}
