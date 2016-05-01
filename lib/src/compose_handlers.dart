import 'handler.dart';
import 'middleware.dart';
import 'pipeline.dart';
import 'send_request.dart';

export 'middleware.dart';
export 'handler.dart';

/// Helper function to compose middleware and a handler.
/// The handler is fixed with [SendRequest].
Handler composeHandlers(List<Middleware> middlewareFunctions) {
  var pipeline = const Pipeline();
  for (Middleware m in middlewareFunctions) {
    pipeline = pipeline.addMiddleware(m);
  }
  return pipeline.addHandler(new SendRequest());
}
