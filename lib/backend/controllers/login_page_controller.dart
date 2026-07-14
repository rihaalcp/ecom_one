import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';

import '../database/mongo_service.dart';

Future<Response> saveLoginPage(Request request) async{
  final body = await request.readAsString();
  final data = jsonDecode(body);
  final collection = MongoService.db.collection("pages");
  
  final existing = await collection.findOne(
    where.eq("page","login")
  );
  if(existing == null){
    await collection.insertOne({
      "page":"login",
      "logoUrl": data["logoUrl"],
      "logoText": data["logoText"],
      "description": data["description"],
      "heading": data["heading"],
      "subHeading": data["subHeading"],
      "emailLabel": data["emailLabel"],
      "emailPlaceholder": data["emailPlaceholder"],
      "passwordLabel": data["passwordLabel"],
      "passwordPlaceholder": data["passwordPlaceholder"],
      "rememberMe": data["rememberMe"],
      "forgotPassword": data["forgotPassword"],
      "loginButton": data["loginButton"],
      "googleButton": data["googleButton"],
      "appleButton": data["appleButton"],
      "signupText": data["signupText"],
      "signupButton": data["signupButton"]
    });
    return Response.ok(
      jsonEncode({
        "success":true,
        "message":"Page Created Success"
      }),
      headers: {"Content-Type":"application/json"}
    );
  }
    await collection.updateOne(
    where.eq("page", "login"),
    modify
      ..set("logoUrl", data["logoUrl"])
      ..set("logoText", data["logoText"])
      ..set("description", data["description"])
      ..set("heading", data["heading"])
      ..set("subHeading", data["subHeading"])
      ..set("emailLabel", data["emailLabel"])
      ..set("emailPlaceholder", data["emailPlaceholder"])
      ..set("passwordLabel", data["passwordLabel"])
      ..set("passwordPlaceholder", data["passwordPlaceholder"])
      ..set("rememberMe", data["rememberMe"])
      ..set("forgotPassword", data["forgotPassword"])
      ..set("loginButton", data["loginButton"])
      ..set("googleButton", data["googleButton"])
      ..set("appleButton", data["appleButton"])
      ..set("signupText", data["signupText"])
      ..set("signupButton", data["signupButton"]),
  );
  return Response.ok(
    jsonEncode({
      "success":true,
      "message":"page Updated"
    }),
    headers:{"Content-Type":"application/json"}
  );
}

Future<Response> getLoginPage(Request request)async{
  final page = await MongoService.db.collection("pages").findOne(where.eq("page","login"));
  if(page == null){
    return Response(
      404,
      body: jsonEncode({
        "success":false,
        "message":"No Data"
      }),
        headers: {"Content-Type":"application/json"}
    );
  }
  return Response.ok(
    jsonEncode(page),
    headers: {"Content-Type":"application/json"}
  );
}