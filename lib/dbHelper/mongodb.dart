import 'dart:convert';
import 'dart:developer';

import 'package:flutter_verbos/mongoDbModel.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoDataBase{ // Conexão com banco de dados
  static var db, userCollection;
  static final  MongoUrl = "mongodb+srv://${dotenv.env["USER"]}:${dotenv.env["PASSWORD"]}@cluster0.jiz8pb1.mongodb.net/?retryWrites=true&w=majority";

  static connect() async{
    db = await Db.create(MongoUrl);
    await db.open();
    inspect(db);
    userCollection = db.collection(dotenv.env["USER_COLLECTION"]);
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

  static Future getData() async {
    
    // find() para pegar todos os dados da collection.
    final arrData = await userCollection.find().toList();
    print("arrDATA é: ${arrData.runtimeType}");
    
    return arrData;
  }

}