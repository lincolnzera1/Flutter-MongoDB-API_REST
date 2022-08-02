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

ScrollController listScrollController = ScrollController();



class _FeedPageState extends State<FeedPage> {

  Future? dataFuture;
  PrefsService prefs = PrefsService();

  

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    controle(){
      if (listScrollController.hasClients) {
        setState(() {
          final position = listScrollController.position.minScrollExtent;
        listScrollController.jumpTo(position);
        print("Passei por aqui?");
        });
      }
      print("dkwopqopek12oopk12okopr1opkkop13r");
    }

    dataFuture = MongoDataBase.getPosts();
  
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Appbar"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            PrefsService.logout();
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => LoginScreen()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: postController,
                ),
                ElevatedButton(onPressed: () async {
                  var date = DateTime.now();
                  String dataTempo = "0${date.day}-0${date.month}-${date.year} - ${date.hour}:${date.minute}:${date.second}";
      
                  await _insert(postController.text, dataTempo);
                  setState(() {
                    dataFuture = MongoDataBase.getPosts();
                    postController.text = "";
                  }); 
                  
                }, child: Text("enviar")),
                Container(
                  height: 400,
                  width: 300,
                  child: FutureBuilder(
                  future: dataFuture,
      
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }else{
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index){
                            return ListTile(
                              // Mostra os dados da lista invertido, pra mostrar 1º o post mais novo.
                              title: Text("${snapshot.data.reversed.toList()[index]["name"]}: ${snapshot.data.reversed.toList()[index]["post"]}"),
                              subtitle: Text("${snapshot.data.reversed.toList()[index]["date"]}"),
      
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
      ),
    );
  }

  Future _insert (String post, String date) async {
    var getName = await PrefsService.getName();
    var data = PostModel(post: post, date: date, name: getName);
    var result = MongoDataBase.inserPost(data);
    

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar( backgroundColor: Colors.green, content: Text("Post feito com sucesso!")));
  }
}