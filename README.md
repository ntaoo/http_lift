# http_lift

HttpLift is inspired by AngularJSv1's http intercepter and shelf.dart.

## Usage

A simple usage example:

    import 'package:http_lift/http_lift.dart';

    main() async {
        LiftClient client = new LiftClient();
        Response response = await client.get('foo url');
        Response response = await client.post('foo url', 'bar body');
        Response response = await client.put('foo url', 'bar body');
        Response response = await client.patch('foo url', 'bar body');
        Response response = await client.delete('foo url');
        Response response = await client.head('foo url');
    }


### With Angular2 and Dependency Injection.

#### Extends LiftClient and add @Injectable() for DI.

    // Extends LiftClient and add @Injectable() for DI.
    import 'package:angular2/core.dart';
    import 'package:http_lift/http_lift.dart' as lift;

    // The opaque token needs to satisfy DI with factory provider.
    const handler = const OpaqueToken('Handler');

    @Injectable()
    class LiftClient extends lift.LiftClient {
      LiftClient(@Inject(handler) handler) : super(handler);
    }

#### Extends Middleware that needs DI.

    // middleware/http_exception.dart
    // For middleware that needs DI also needs to extend to add @Injectable.
    import 'package:angular2/core.dart';
    import 'package:http_lift/middleware/http_exception.dart' as lift_middleware;

    @Injectable()
    class HttpExceptionEvents extends lift_middleware.HttpExceptionEvents {}

    // You can't define type alias in Dart. So just extending.
    @Injectable()
    class HttpException extends lift_middleware.HttpException {
      HttpException(HttpExceptionEvents httpExceptionEvents)
          : super(httpExceptionEvents);
    }

#### Compose LiftClient middleware and add @Injectable() for DI.

    // Compose LiftClient middleware and add @Injectable() for DI.
    import 'package:angular2/core.dart';
    import 'package:http_lift/http_lift.dart' hide HttpException;
    import 'package:http_lift/middleware/json.dart';
    import 'package:http_lift/middleware/xsrf_token.dart';
    import 'middleware/http_exception.dart';

    @Injectable()
    Handler handlerFactory(HttpExceptionEvents httpExceptionEvents) =>
        composeHandlers([
          json(),
          xsrfToken(),
          new HttpException(httpExceptionEvents).createMiddleware()
        ]);

#### Configure DI.

    const List resourceProviders = const [
      HttpExceptionEvents,
      const Provider(handler,
          useFactory: handlerFactory, deps: const [HttpExceptionEvents]),
      const Provider(LiftClient, useClass: LiftClient),
      const Provider(FooResource,
          useClass: FooResource, deps: const [LiftClient]),
    ];

* More documentation will be available in the next version.
* API is in flux and may change.

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/ntaoo/http_lift/issues


#### TODO

- Fix the license.
- Pub publish.
- Write tests.
- Improve README.
- Write doc comments.
- Provide logging middleware.