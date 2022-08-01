// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';
import 'package:flutter_verbos/pages/initialPage.dart';
import 'package:flutter_verbos/postModel.dart';
import 'package:flutter_verbos/services/prefs_service.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({ Key? key }) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

TextEditingController postController = TextEditingController();




class _FeedPageState extends State<FeedPage> {

  Future? dataFuture;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    dataFuture = MongoDataBase.getPosts();
    
  }

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
              TextField(
                controller: postController,
              ),
              ElevatedButton(onPressed: () async {
                var date = DateTime.now();
                await _insert(postController.text, date.toString());
                setState(() {
                  dataFuture = MongoDataBase.getPosts();
                });
              }, child: Text("dqw")),
              Container(
                height: 400,
                width: 300,
                child: FutureBuilder(
                future: dataFuture,
                builder: (context, AsyncSnapshot snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }else{
                    if(snapshot.hasData){
                      print("Nossas postagens: ${snapshot.data}");
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index){
                          return ListTile(
                            title: Text("Post: ${snapshot.data[index]["post"]}"),
                            subtitle: Text("${snapshot.data[index]["date"]}"),
                          );
                        }
                      );
                    }else{
                      return const Center(
                        child: Text("No Data available!"),
                      );
                    }
                  }
                }
              ),
              )
            ]
          ),
        ),
      ),
    );
  }

  _insert (String post, String date) async {
    var data = PostModel(post: post, date: date);
    var result = MongoDataBase.inserPost(data);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar( backgroundColor: Colors.green, content: Text("Post feito com sucesso!")));
  }
}