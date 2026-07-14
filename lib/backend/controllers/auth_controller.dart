import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import '../database/mongo_service.dart';

Future<Response> registerUser(Request request)async{
  final body= await request.readAsString();
  final data = jsonDecode(body);

  final exisitingUser =  await MongoService.users.findOne(
    where.eq("email", data["email"])
  );
  if(exisitingUser != null){
    return Response(
      400,
      body: jsonEncode({
        "success":false,
        "message":"Email already exist"
      }),
      headers: {"Content-Type":"application/json"}
    );
  }
  await MongoService.users.insertOne({
    "name":data["name"],
    "email":data["email"],
    "phone":data["phone"],
    "password":data["password"],
    "role":"user"
});
return Response.ok(
  jsonEncode({
    "success":true,
    "message":"Register Success"
  }),
  headers: {"Content-Type":"application/json"}
);
}
Future<Response> loginUser(Request request) async{
  final body = await request.readAsString();
  final data = jsonDecode(body);

  final user = await MongoService.users.findOne(
    where.eq("email",data["email"])
);
if(user == null){
  return Response(
    400,
    body: jsonEncode({
      "success":false,
      "message":"Please Register to login"
    }),
    headers: {"Content-Type":"application/json"}
  );
}
if(user["password"] != data["password"]){
  return Response(
    401,
    body: jsonEncode({
      "success":false,
      "message":"password not match"
    }),
    headers: {"Content-Type":"application/json"}
  );
}
return Response.ok(
  jsonEncode({
    "success": true,
    "message": "Login Success",
    "_id": user["_id"].toString(),
    "name": user["name"],
    "email": user["email"],
    "phone": user["phone"],
    "role": user["role"],
  }),
  headers: {
    "Content-Type": "application/json",
  },
);
}
Future<Response> getUsers (Request request)async{
  final users = await MongoService.users.find().toList();
  return Response.ok(
    jsonEncode(
      users
    ),
    headers: {"Content-Type":"application/json"}
  );
}