import 'dart:html';

import 'package:cookies/cookies.dart';
import '../http_lift.dart';

const String _cookieKey = 'xsrfToken';

const String _httpHeader = 'X-XSRF-TOKEN';

Middleware xsrfToken() => createMiddleware(requestHandler: _requestHandler);

/// Currently only supports cookie and not configurable.
_requestHandler(Request request) {
  Cookie cookie = new CookieJar(document.cookie)[_cookieKey];
  request.headers[_httpHeader] = cookie != null ? cookie.value : '';
}
