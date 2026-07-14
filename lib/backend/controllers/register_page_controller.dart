import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../database/mongo_service.dart';

class RegisterPageController {
  Future<Response> saveRegisterPage(Request request) async {
    try {
      final body = await request.readAsString();

      final data = jsonDecode(body);

      final collection = MongoService.db.collection("pages");
      final existing = await collection.findOne(where.eq("page", "register"));
      if (existing == null) {
        await collection.insertOne({
          "page": "register",
          "title": data["title"],
          "subtitle": data["subtitle"],
          "fullNameLabel": data["fullNameLabel"],
          "fullNameHint": data["fullNameHint"],
          "emailLabel": data["emailLabel"],
          "emailHint": data["emailHint"],
          "phoneLabel": data["phoneLabel"],
          "phoneHint": data["phoneHint"],
          "passwordLabel": data["passwordLabel"],
          "passwordHint": data["passwordHint"],
          "confirmPasswordLabel": data["confirmPasswordLabel"],
          "confirmPasswordHint": data["confirmPasswordHint"],
          "googleLabel": data["googleLabel"],
          "googleHint": data["googleHint"],
          "appleLabel": data["appleLabel"],
          "appleHint": data["appleHint"],
          "buttonText": data["buttonText"],
        });

        return Response.ok(
          jsonEncode({"success": true, "message": "Register page created"}),
          headers: {"content-type": "application/json"},
        );
      }
      await collection.updateOne(
        where.eq("page", "register"),
        modify
            .set("page", "register")
            .set("title", data["title"])
            .set("subtitle", data["subtitle"])
            .set("fullNameLabel", data["fullNameLabel"])
            .set("fullNameHint", data["fullNameHint"])
            .set("emailLabel", data["emailLabel"])
            .set("emailHint", data["emailHint"])
            .set("phoneLabel", data["phoneLabel"])
            .set("phoneHint", data["phoneHint"])
            .set("passwordLabel", data["passwordLabel"])
            .set("passwordHint", data["passwordHint"])
            .set("confirmPasswordLabel", data["confirmPasswordLabel"])
            .set("confirmPasswordHint", data["confirmPasswordHint"])
            .set("googleLabel", data["googleLabel"])
            .set("googleHint", data["googleHint"])
            .set("appleLabel", data["appleLabel"])
            .set("appleHint", data["appleHint"])
            .set("buttonText", data["buttonText"]),
        upsert: true,
      );

      return Response.ok(
        jsonEncode({"success": true, "message": "Register page saved"}),
        headers: {"content-type": "application/json"},
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({"error": e.toString()}),
      );
    }
  }

  Future<Response> getRegisterPage(Request request) async {
    try {
      final result = await MongoService.db
          .collection("pages")
          .findOne(where.eq("page", "register"));
      if (result == null) {
        return Response(
          404,
          body: jsonEncode({"error": "Register page not found"}),
          headers: {"content-type": "application/json"},
        );
      }
      return Response.ok(
        jsonEncode(result),

        headers: {"content-type": "application/json"},
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({"error": e.toString()}),
      );
    }
  }
}
