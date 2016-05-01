import 'package:http_exception/http_status.dart';
export 'package:http_exception/http_status.dart';

abstract class ExtendedHttpStatus extends HttpStatus {
  static const int UNPROCESSABLE_ENTITY = 422;
}
