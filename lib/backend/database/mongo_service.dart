import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  static late Db db;
  static Future<void> connect() async{
    db = await Db.create(
      "mongodb+srv://rihaalcp22_db_user:39xVYVeGavSaCmjh@cluster0.v1caqbd.mongodb.net/ecom?appName=Cluster0"
    );
    await db.open();
    print("MongoDb Connected");
  }
  static DbCollection get users => db.collection("users");
}