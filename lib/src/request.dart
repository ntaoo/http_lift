import 'util/methods.dart';

// Request DTO. Currently the encoding is fixed to default (utf-8).
class Request<T> {
  final Method method;
  String url;
  Map<String, String> headers;
  T body;

  Request(this.method, this.url, {headers, this.body})
      : this.headers = headers ?? {};
}
