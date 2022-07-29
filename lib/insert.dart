// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';
import 'package:flutter_verbos/mongoDbModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({ Key? key }) : super(key: key);

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {

  var firstNameController = new TextEditingController();
  var lastNameController = new TextEditingController();
  var addressController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("hello, world!"),
            TextField(
              decoration: InputDecoration(labelText: "First name: "),
              controller: firstNameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Last name: "),
              controller: lastNameController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Address: "),
              controller: addressController,
              minLines: 3,
              maxLines: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: (){
                    _fakeData();
                  }, 
                  child: Text("Generate Data")
                ),
                ElevatedButton(
                  onPressed: (){
                    _insert(firstNameController.text, lastNameController.text, addressController.text);
                  }, 
                  child: Text("Insert Data")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _fakeData(){
    setState(() {
      firstNameController.text = faker.person.firstName();
      lastNameController.text = faker.person.lastName();
      addressController.text = faker.address.streetName() + "\n" + faker.address.streetAddress();
    }); 
  }

  Future _insert (String firstName, String lastName, String address) async{
    
    var _id = M.ObjectId();
    final data = MongoDbModel(id: _id, firstName: firstName, lastName: lastName, address: address); // Scheme pelo visto
    var result = MongoDataBase.insert(data); // Método da classe MongoDataBase
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID: " + _id.$oid)));
    _clearAll();
  }

  void _clearAll(){
    firstNameController.text = "";
    lastNameController.text = "";
    addressController.text = "";
  }

}