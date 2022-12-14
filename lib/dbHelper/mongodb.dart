import 'dart:convert';
import 'dart:developer';

import 'package:flutter_verbos/mongoDbModel.dart';
import 'package:flutter_verbos/mongoModel2.dart';
import 'package:flutter_verbos/postModel.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MongoDataBase{ // Conexão com banco de dados
  static var db, userCollection, postCollection;
  static final  MongoUrl = "mongodb+srv://${dotenv.env["USER"]}:${dotenv.env["PASSWORD"]}@cluster0.jiz8pb1.mongodb.net/?retryWrites=true&w=majority";

  static connect() async{
    db = await Db.create(MongoUrl);
    await db.open();
    inspect(db);
    
    userCollection = db.collection(dotenv.env["USER_COLLECTION"]);
    postCollection = db.collection(dotenv.env["POST_COLLECTION"]);
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

  static Future<String> insert2(MongoModel2 data) async {
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

  static Future<String> inserPost (PostModel data) async {
    try {
      var result = postCollection.insertOne(data.toJson());
      if(result.isSuccess){
        return "Data inserted";
      }else{
        return "Something wrong";
      }
    } catch (e) {
      return "$e error *****";
    }
  }

  

  static Future<List> getData() async {
    
    // find() para pegar todos os dados da collection.
    final arrData = await userCollection.find().toList();
    //print("arrDATA é: ${arrData.runtimeType}");
    return arrData;
  }

  static Future<List> getPosts() async {
    
    // find() para pegar todos os dados da collection.
    final arrData = await postCollection.find().toList();
    print("arrDATA é: ${arrData.runtimeType}");
    return arrData;
  }

  /* static Future authEmail() async{
    final arrData = await userCollection.find().toList();
    for(var elemento in arrData){
      if(elemento["email"])
    }
  } */

}