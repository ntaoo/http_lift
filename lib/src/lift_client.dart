import 'dart:async';

import 'handler.dart';
import 'request.dart';
import 'response.dart';
import 'send_request.dart';
import 'util/methods.dart';

/// If a handler is not provided on the constructor, then [SendRequest] is set to the [_handler].
class LiftClient {
  Handler _handler;

  LiftClient([Handler _handler])
      : this._handler = _handler ?? new SendRequest();

  Future<Response> get(String url) =>
      _handleRequest(new Request(Method.get, url));

  Future<Response> post(String url, body) =>
      _handleRequest(new Request(Method.post, url, body: body));

  Future<Response> put(String url, body) =>
      _handleRequest(new Request(Method.put, url, body: body));

  Future<Response> patch(String url, body) =>
      _handleRequest(new Request(Method.patch, url, body: body));

  Future<Response> delete(String url) =>
      _handleRequest(new Request(Method.delete, url));

  Future<Response> head(String url) =>
      _handleRequest(new Request(Method.head, url));

  Future<Response> _handleRequest(Request request) {
    try {
      return new Future.sync(() => _handler(request));
    } catch (error, stackTrace) {
      // TODO: implement more error handling.
      throw ('An Unexpected error: $error, $stackTrace');
    }
  }
}
