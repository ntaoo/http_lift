import 'dart:async';

import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http show Response;

import 'request.dart';
import 'response.dart';
import 'util/methods.dart';

class SendRequest {
  final BrowserClient _client = new BrowserClient();

  Future<Response> call(Request request) async {
    http.Response response;
    switch (request.method) {
      case Method.get:
        response = await _client.get(request.url, headers: request.headers);
        break;
      case Method.post:
        response = await _client.post(request.url,
            headers: request.headers, body: request.body);
        break;
      case Method.put:
        response = await _client.put(request.url,
            headers: request.headers, body: request.body);
        break;
      case Method.patch:
        response = await _client.patch(request.url,
            headers: request.headers, body: request.body);
        break;
      case Method.delete:
        response = await _client.delete(request.url, headers: request.headers);
        break;
      case Method.head:
        response = await _client.head(request.url, headers: request.headers);
        break;
      default:
        throw new UnsupportedError(
            'The method ${request.method} is not supported.');
    }
    return new Response(response.body, response);
  }
}
