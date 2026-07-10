import 'dart:io';

import 'package:globa_one/backend/database/mongo_service.dart';
import 'package:globa_one/backend/routes/auth_routes.dart';
import 'package:shelf/shelf_io.dart' as io;


Future<void> main() async{
  await MongoService.connect();
  final handler = AuthRoutes().router;
  final server = await io.serve(
    handler,
    InternetAddress.anyIPv4,
    5000
  );
  print(
    "server running on ${server.address.host}:${server.port}",
  );
}