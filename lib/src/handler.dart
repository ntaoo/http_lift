import 'request.dart';

/// Should return [Response] or [Future<Response>].
typedef Handler(Request request);
