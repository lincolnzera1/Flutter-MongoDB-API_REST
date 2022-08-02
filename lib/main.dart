import 'dart:convert';

 import 'package:flutter/material.dart'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_verbos/classes/pessoas.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';
import 'package:flutter_verbos/get.dart';
import 'package:flutter_verbos/insert.dart';
import 'package:flutter_verbos/pages/feedPage.dart';
import 'package:flutter_verbos/pages/initialPage.dart';
import 'package:flutter_verbos/pages/registerPage.dart';
import 'package:flutter_verbos/pages/splash2Screen.dart';
import 'package:flutter_verbos/pages/splashScreen.dart';
import 'package:flutter_verbos/verbos.dart';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';

Future main() async{
  await dotenv.load();
  //Chama a conexão com o database, quando o app inicia
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDataBase.connect();
  
  runApp(MyApp());


}

  class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.lightGreen),
             borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.lightGreen),
             borderRadius: BorderRadius.all(Radius.circular(15))
          ),
        ),
      ),
      home: splash2Screen(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/feed": (_) => FeedPage(),
        "/register": (_) => RegisterPage(),
        "/login":(_) => LoginScreen()
      },
    );
  }
}  