// To parse this JSON data, do
//
//     final mongoModel2 = mongoModel2FromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoModel2 mongoModel2FromJson(String str) => MongoModel2.fromJson(json.decode(str));

String mongoModel2ToJson(MongoModel2 data) => json.encode(data.toJson());

class MongoModel2 {
    MongoModel2({
        required this.id,
        required this.nome,
        required this.email,
        required this.password,
    });

    ObjectId id;
    String nome;
    String email;
    String password;

    factory MongoModel2.fromJson(Map<String, dynamic> json) => MongoModel2(
        id: json["id"],
        nome: json["nome"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "email": email,
        "password": password,
    };
}
