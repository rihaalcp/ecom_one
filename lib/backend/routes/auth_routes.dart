import 'dart:convert';
import 'package:globa_one/backend/models/user.dart';
import 'package:globa_one/backend/services/auth_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';



class AuthRoutes {
  Router get router{
    final router = Router();
    router.post("/register",(Request request) async{
      final body = jsonDecode(
        await request.readAsString()
      );
      final user = User(
        name: body["name"],
        email: body["email"],
        phone: body["phone"],
        password: body["password"]
      );
      final success = await AuthService.register(user);
      if(success){
        return Response.ok("Registered");
      }
      return Response(
        400,
        body: "Email Already Exists"
      );
    });

    router.post("/login",(Request request) async{
      final body = jsonDecode(
        await request.readAsString(),
      );
      final user = await AuthService.login(
        body["email"],
        body["password"]
      );
      if(user == null){
        return Response(
          401,
          body:"Invalid Login"
        );
      }
      return Response.ok(
        jsonEncode(user),
        headers: {
          "Content-Type":"application/json"
        }
      );
    });
    router.get("/",(Request request)async{
      return Response(
        200,
        body:"Your Applicaion working perfectly"
      );
    });
    return router;
  }
}