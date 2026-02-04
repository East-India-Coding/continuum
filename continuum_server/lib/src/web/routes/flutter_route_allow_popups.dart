import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

class WasmHeadersAllowPopupsMiddleware extends MiddlewareObject {
  const WasmHeadersAllowPopupsMiddleware();

  @override
  Handler call(Handler next) {
    return (Request req) async {
      final result = await next(req);

      if (result is Response) {
        return result.copyWith(
          headers: result.headers.transform((mh) {
            mh.crossOriginOpenerPolicy =
                CrossOriginOpenerPolicyHeader.sameOriginAllowPopups;
            mh.crossOriginEmbedderPolicy =
                CrossOriginEmbedderPolicyHeader.requireCorp;
          }),
        );
      }

      return result;
    };
  }
}

class FlutterRouteAllowPopups extends Route {
  final Directory directory;
  final File? indexFile;
  final CacheControlFactory? cacheControlFactory;
  final CacheBustingConfig? cacheBustingConfig;

  FlutterRouteAllowPopups(
    this.directory, {
    this.indexFile,
    this.cacheControlFactory,
    this.cacheBustingConfig,
  }) : super(methods: {Method.get, Method.head});

  @override
  void injectIn(RelicRouter router) {
    final subRouter = Router<Handler>();

    subRouter.use('/', const WasmHeadersAllowPopupsMiddleware().call);

    final index =
        indexFile ?? File(directory.uri.resolve('index.html').toFilePath());

    subRouter.use(
      '/',
      FallbackMiddleware(
        fallback: StaticRoute.file(index),
        on: (response) => response.statusCode == 404,
      ).call,
    );

    StaticRoute.directory(
      directory,
      cacheBustingConfig: cacheBustingConfig,
      cacheControlFactory: cacheControlFactory ?? (_, _) => null,
    ).injectIn(subRouter);

    router.attach('/', subRouter);
  }

  @override
  FutureOr<Result> handleCall(Session session, Request request) {
    throw UnimplementedError(
      'FlutterRouteAllowPopups handles routing via injectIn and should not be called directly',
    );
  }
}
