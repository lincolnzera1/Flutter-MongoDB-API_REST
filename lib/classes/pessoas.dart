import 'package:mongo_dart/mongo_dart.dart';

class Pessoas{

  ObjectId? id;
  String? nome;
  int? idade;

  Pessoas({this.id, this.nome, this.idade});

}