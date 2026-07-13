import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../../backend/controllers/auth_controller.dart';
class AuthRoutes {
  Router get router{
    final router = Router();
    router.post('/register',registerUser);
    router.post('/login',loginUser);
    router.get('/users',getUsers);
    router.get('/',(request) async{
      return Response(
        404,
        body:jsonEncode({
          "success":false,
          "message": "route not found"
        }),
        headers: {"Content-Type":"application/json"}
      );
    });
    return router;
  }
}