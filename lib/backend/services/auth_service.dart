import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../database/mongo_service.dart';
import '../models/user.dart';

class AuthService {
  static String hashPassword(String password){
    return sha256.convert(
      utf8.encode(password),
    ).toString();
  }

static Future<bool> register(User user) async{
  final users = MongoService.users;
  final old = await users.findOne({
    "email":user.email,
  });
  if(old != null){
    throw Exception("Email already exists");
  }

  user.password = hashPassword(user.password);
  await users.insertOne(
    user.toJson()
  );
  return true;
}

static Future<Map?> login(
  String email,
  String password,
)async{
  final users = MongoService.users;
  final user = await users.findOne({
    "email":email
  });
  if(user == null){
    throw Exception("User not Found");
  }
  if(user["password"] != hashPassword(password)){
    throw Exception("Invalid Password");
  }
  return {
      "_id": user["_id"].toString(),
      "name": user["name"],
      "email": user["email"],
      "phone": user["phone"],
    };
}
}