import 'package:flutter/material.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';

class GetData extends StatefulWidget {
  const GetData({ Key? key }) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDataBase.getData(),
          builder: (context, AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              if(snapshot.hasData){
                var totalData = snapshot.data.length;
                print("$totalData é o totalData");
                print("${snapshot.data} são os dados.");
                return ListView.builder(
                  itemCount: totalData,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text("Usuário: ${snapshot.data[index]["firstName"]}"),
                    );
                  });
                //return Center(child: Text("Data inserted"),);
              }else{
                return const Center(child: Text("No Data available."));
              }
            }
          },
        ),
      ),
    );
  }
}