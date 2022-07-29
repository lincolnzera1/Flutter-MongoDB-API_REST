import 'dart:developer';

import 'package:flutter_verbos/dbHelper/constantStrings.dart';
import 'package:flutter_verbos/mongoDbModel.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDataBase{ // Conexão com banco de dados
  static var db, userCollection;

  static connect() async{
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = userCollection.insertOne(data.toJson()); // só essa linha praticamente
      if(result.isSuccess){
        return "Data inserted";
      }else{
        return "Something wrong";
      }
    } catch (e) {
      return "$e error *****";
    }
  }


}