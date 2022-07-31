// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_verbos/pages/initialPage.dart';
import 'package:flutter_verbos/services/prefs_service.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({ Key? key }) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appbar"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            PrefsService.logout();
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => LoginScreen()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              Text("logged in, congrats")
            ],
          ),
        ),
      ),
    );
  }
}