import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AuthRoutes {
  Router get router {
    final router = Router();

    // Register
    router.post("/register", (Request request) async {
      try {
        final body = jsonDecode(await request.readAsString());

        final user = User(
          name: body["name"],
          email: body["email"],
          phone: body["phone"],
          password: body["password"],
        );

        await AuthService.register(user);

        return Response(
          201,
          body: jsonEncode({
            "message": "Registered Successfully",
          }),
          headers: {
            "Content-Type": "application/json",
          },
        );
      } catch (e) {
        return Response(
          400,
          body: jsonEncode({
            "message": e.toString().replaceFirst("Exception: ", ""),
          }),
          headers: {
            "Content-Type": "application/json",
          },
        );
      }
    });

    // Login
    router.post("/login", (Request request) async {
      try {
        final body = jsonDecode(await request.readAsString());

        final user = await AuthService.login(
          body["email"],
          body["password"],
        );

        return Response.ok(
          jsonEncode(user),
          headers: {
            "Content-Type": "application/json",
          },
        );
      } catch (e) {
        return Response(
          401,
          body: jsonEncode({
            "message": e.toString().replaceFirst("Exception: ", ""),
          }),
          headers: {
            "Content-Type": "application/json",
          },
        );
      }
    });

    // Home
    router.get("/", (Request request) {
      return Response.ok(
        "Your Application is working perfectly",
      );
    });

    return router;
  }
}