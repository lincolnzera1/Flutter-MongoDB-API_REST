import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClasseApropriada extends StatefulWidget {
  const ClasseApropriada({ Key? key }) : super(key: key);

  @override
  State<ClasseApropriada> createState() => _ClasseApropriadaState();
}

class Comunicacao{

  int? tamanho;
  var json;
  var dados;
  List<dynamic> listaDeDados = [];

  Future fetch() async {
    var url = "https://jsonplaceholder.typicode.com/todos";
    var response = await http.get(Uri.parse(url));
    json =  jsonDecode(response.body);
    
    listaDeDados = json;
    print(listaDeDados);
  }
}

var comunicacao = Comunicacao();


class _ClasseApropriadaState extends State<ClasseApropriada> {
  @override
  Widget build(BuildContext context) {
    comunicacao.fetch();
    return Container(
      
    );
  }
}


