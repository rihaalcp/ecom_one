import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
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
    return false;
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
    return null;
  }
  if(user["password"] != hashPassword(password)){
    return null;
  }
  return user;
}
}






















































































































































































































































































































































