import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class WidgetChamada extends StatefulWidget {
  const WidgetChamada({ Key? key }) : super(key: key);

  @override
  State<WidgetChamada> createState() => _WidgetChamadaState();
}



class _WidgetChamadaState extends State<WidgetChamada> {

  List dados = [];

Future fetch() async {
  String url = "https://jsonplaceholder.typicode.com/todos/";
  var response = await http.get(Uri.parse(url));
  var json = jsonDecode(response.body);
  
  setState(() {
    dados = json;
  });
}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dados.length,
      itemBuilder: (context, index) {
          return ListTile(
            title: Text("${dados[index]['id']} - ${dados[index]['title']} - ${dados[index]['userId']}"),
          );
      }
    );
  }


}