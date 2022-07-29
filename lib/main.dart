import 'dart:convert';

 import 'package:flutter/material.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter_verbos/classes/pessoas.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';
import 'package:flutter_verbos/insert.dart';
import 'package:flutter_verbos/verbos.dart';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';

Future main() async{
  //Chama a conexão com o database, quando o app inicia
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDataBase.connect();
  
  runApp(MyApp());
  var pessoas = Pessoas();


}

  class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MongoDbInsert(),
      debugShowCheckedModeBanner: false,
    );
  }
}  