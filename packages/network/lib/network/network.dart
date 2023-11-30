import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:network/network/network_exception.dart';
import 'package:network/network/url_resolver.dart';

abstract interface class HttpNetwork {
  HttpNetwork();

  factory HttpNetwork.client() {
    return HttpNetworkImpl(client: http.Client());
  }

  Future<Map<String, dynamic>> get(URLResolver url);

  Future<Map<String, dynamic>> post(URLResolver url, Map<String, dynamic> body);
}

class HttpNetworkImpl extends HttpNetwork {
  final http.Client client;

  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  HttpNetworkImpl({required this.client});

  @override
  Future<Map<String, dynamic>> get(URLResolver url) async {
    var response = await client.get(url.fullURI(), headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw NetworkException(statusCode: response.statusCode);
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      URLResolver url, Map<String, dynamic> body) async {
    var encodedBody = convert.jsonEncode(body);
    var response =
        await client.post(url.fullURI(), body: encodedBody, headers: headers);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw NetworkException(statusCode: response.statusCode);
    }
  }
}
