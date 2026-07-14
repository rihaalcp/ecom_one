import 'dart:io';

import '../lib/backend/database/mongo_service.dart';
import '../lib/backend/routes/auth_routes.dart';
import '../lib/backend/routes/login_page_route.dart';
import '../lib/backend/routes/register_page_route.dart';

import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  await MongoService.connect();
  final router = Router();
  router.mount('/', AuthRoutes().router.call);
  router.mount('/', RegisterPageUpdate().router.call);
  router.mount('/', LoginPageUpdate().router.call);

  final handler = Pipeline()
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, 5000);
  print("Server running on http://${server.address.host}:${server.port}");
}

Middleware corsHeaders() {
  return createMiddleware(
    requestHandler: (Request request) {
      if (request.method == 'OPTIONS') {
        return Response.ok(
          '',
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          },
        );
      }
      return null;
    },
    responseHandler: (Response response) {
      return response.change(
        headers: {
          ...response.headers,
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        },
      );
    },
  );
}
