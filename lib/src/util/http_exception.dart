import 'package:http_exception/http_exception.dart';
import 'http_status.dart';

export 'package:http_exception/http_exception.dart';

/// 422 Unprocessable Entity
/// Currently only one implementation from https://tools.ietf.org/html/rfc4918
class UnprocessableEntityException extends HttpException {
  const UnprocessableEntityException(
      [Map<String, dynamic> data, String detail = ''])
      : super(ExtendedHttpStatus.UNPROCESSABLE_ENTITY,
            'Unprocessable Entity${(detail != '' ? ': ' : '')}$detail', data);
}
