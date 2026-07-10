import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

import '../lib/backend/database/mongo_service.dart';
import '../lib/backend/routes/auth_routes.dart';

Middleware corsHeaders() {
  return (Handler innerHandler) {
    return (request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers':
              'Origin, Content-Type, Accept, Authorization',
          'Access-Control-Allow-Methods':
              'GET, POST, PUT, DELETE, OPTIONS',
        });
      }

      final response = await innerHandler(request);

      return response.change(headers: {
        ...response.headers,
        'Access-Control-Allow-Origin': '*',
      });
    };
  };
}

Future<void> main() async {
  // Connect to MongoDB FIRST
  await MongoService.connect();

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(AuthRoutes().router);

  final server = await io.serve(
    handler,
    InternetAddress.anyIPv4,
    5000,
  );

  print("Server running on http://${server.address.host}:${server.port}");
}