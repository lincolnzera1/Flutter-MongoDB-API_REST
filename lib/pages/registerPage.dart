// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';
import 'package:flutter_verbos/insert.dart';
import 'package:flutter_verbos/styles/logIn.dart';
import 'package:flutter_verbos/widgets/textfield.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:flutter_verbos/mongoModel2.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // Criar os controllers aqui.

  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
    


  @override
  Widget build(BuildContext context) {

    
  dynamic altura = MediaQuery.of(context).size.height;
    
  
  
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Cadastro"),centerTitle: true,),
      body: SingleChildScrollView (
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(height: altura * 0.05,),
                const Text("Cadastre-se", style: login,),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Insira seu email",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()
                  ), 
                  controller: emailController,
                ),
                const SizedBox(height: 10,),            
                TextFormField(
                  style: TextStyle(color: Colors.white),
                   decoration: InputDecoration(
                    hintText: "Insira sua senha",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Senha",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()
                  ), 
                  controller: passwordController,
                  
                ),
                SizedBox(height: altura * 0.05,),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                   decoration: InputDecoration(
                    hintText: "Insira sua senha novamente",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Confirmar Senha",
                    labelStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder()
                  ), 
                  controller: confirmPasswordController,
                  
                ),
                SizedBox(height: altura * 0.05,),
                InkWell(
                  onTap: () async {
                    await registrar();
                  },
                  child: Ink(
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                      height: 55,
                      width: 350,
                      child: Center(child: Text("Cadastrar", style: loginButtonText,),),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }

  Future _insert(String email, String password, String confirmPassword) async{

    var _id = M.ObjectId();
    final data = MongoModel2(id: _id, email: email, password: password);
    var result = MongoDataBase.insert2(data);
    //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID: " + _id.$oid)));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar( backgroundColor: Colors.green, content: Text("Cadastro feito com sucesso!")));
  }

  Future registrar() async {
    List dados = await MongoDataBase.getData();
    if(passwordController.text == confirmPasswordController.text){
      try {

        for(var i in dados){
          if(i["email"] == emailController.text){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("O email já foi cadastrado!")));

            return;
          }
        }
        // Criptografar senha para o banco de dados.
        var bytes = utf8.encode("${passwordController.text}");
        var digest = sha1.convert(bytes);

        _insert(emailController.text, digest.toString(), confirmPasswordController.text);
        Navigator.pop(context);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Houve um erro, tente novamente mais tarde.")));
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("As senhas não são iguais.")));
    } 
  }

}