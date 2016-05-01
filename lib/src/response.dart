import 'package:http/http.dart' as http show Response;
export 'util/http_status.dart';
export 'util/http_exception.dart';

/// Response DTO with mutable relax typed body.
class Response<T> {
  T body;
  final http.Response _original;

  Response(this.body, http.Response _original) : this._original = _original;

  Map<String, String> get headers => _original.headers;

  int get statusCode => _original.statusCode;
}
