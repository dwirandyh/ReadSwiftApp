import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:network/network/network_exception.dart';

abstract interface class HttpNetwork {
  HttpNetwork();

  factory HttpNetwork.client() {
    return HttpNetworkImpl(client: http.Client());
  }

  Future<Map<String, dynamic>> get(Uri url);

  Future<Map<String, dynamic>> post(Uri url, Map<String, dynamic> body);
}

class HttpNetworkImpl extends HttpNetwork {
  final http.Client client;

  HttpNetworkImpl({required this.client});

  @override
  Future<Map<String, dynamic>> get(Uri url) async {
    var response = await client.get(url);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw NetworkException(statusCode: response.statusCode);
    }
  }

  @override
  Future<Map<String, dynamic>> post(Uri url, Map<String, dynamic> body) async {
    var encodedBody = convert.jsonEncode(body);
    var response = await client.post(url, body: encodedBody);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw NetworkException(statusCode: response.statusCode);
    }
  }
}
