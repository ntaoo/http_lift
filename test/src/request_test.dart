import 'package:http_lift/src/request.dart';
import 'package:http_lift/src/util/methods.dart';

import "package:test/test.dart";

main() {
  test('new', () {
    var request = new Request(Method.get, '/foo');
    expect(request.method, equals(Method.get));
    expect(request.url, equals('/foo'));
    expect(request.headers, equals({}));
    expect(request.body, isNull);
  });
}
