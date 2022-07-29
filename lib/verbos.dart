import 'dart:convert';
import 'package:flutter_verbos/classes/widgetChamada.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_verbos/classes/json.dart';

class Verbos extends StatefulWidget {
  const Verbos({ Key? key }) : super(key: key);

  @override
  State<Verbos> createState() => _VerbosState();
}



class _VerbosState extends State<Verbos>  {


  @override

  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: 
      AppBar(
        title: const Text("JOTA SON"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(height: 200,
          width: 399,child: WidgetChamada(),)
        ],
      )
    );
  }
}