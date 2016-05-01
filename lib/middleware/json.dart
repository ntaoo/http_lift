import 'dart:convert';
import '../http_lift.dart';

Middleware json() => createMiddleware(
    requestHandler: _requestHandler, responseHandler: _responseHandler);

_requestHandler(Request request) {
  request.headers['Content-Type'] = 'application/json';
  request.body = JSON.encode(request.body);
}

Response _responseHandler(Response response) {
  return response..body = JSON.decode(response.body);
}
