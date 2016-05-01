import '../src/util/http_exception.dart' as e;
import '../src/middleware.dart' as m;
import '../src/response.dart';
import '../src/util/http_status.dart';
import '../src/util/event_emitter.dart';

/// If a http response status is an error, it emits an http exception event
/// through [HttpExceptionEvents] streams container object.
class HttpException {
  final HttpExceptionEvents _httpExceptionEvents;

  HttpException(this._httpExceptionEvents);

  m.Middleware createMiddleware() =>
      m.createMiddleware(responseHandler: responseHandler);

  // TODO: Support more http error?
  Response responseHandler(Response response) {
    if (response.statusCode == HttpStatus.UNAUTHORIZED) {
      _httpExceptionEvents.onUnauthorizedException
          .add(const e.UnauthorizedException());
    } else if (response.statusCode == HttpStatus.NOT_FOUND ||
        response.statusCode == ExtendedHttpStatus.UNPROCESSABLE_ENTITY) {
      // Do nothing. These exceptions should be handled the by caller.
    } else if (_isException(response.statusCode)) {
      // Handle other exceptions.
      _httpExceptionEvents.onHttpException
          .add(new e.HttpException(response.statusCode));
    } else {
      // Do nothing. It should be in 2xx-3xx.
    }
    return response;
  }

  bool _isException(int statusCode) =>
      statusCode >= HttpStatus.BAD_REQUEST &&
      statusCode <= HttpStatus.NETWORK_CONNECT_TIMEOUT_ERROR;
}

/// This is to be injected into [HttpException] so that when a http request
/// completes with an error status code, [HttpException] can emit a http exception event.
///
/// With Angular2, this is also to be injected into any component
/// (guessing mostly into a root component)
/// so that it can listen and handle http errors.
///
/// Unlike the term `error` in
/// [the status code definition](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html),
/// `exception` is preferable here because they are the subjects to be caught.
/// See also the `exception` usage in (https://api.dartlang.org/1.12.0/dart-io/HttpException-class.html).
// TODO: More kind of exception support?
class HttpExceptionEvents {
  final EventEmitter<e.UnauthorizedException> onUnauthorizedException =
      new EventEmitter<e.UnauthorizedException>();
  final EventEmitter<e.HttpException> onHttpException =
      new EventEmitter<e.HttpException>();
}
