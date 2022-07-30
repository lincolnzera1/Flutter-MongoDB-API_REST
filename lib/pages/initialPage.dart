import 'package:flutter/material.dart';
import 'package:flutter_verbos/pages/feedPage.dart';
import 'package:flutter_verbos/pages/registerPage.dart';
import 'package:flutter_verbos/styles/logIn.dart';
import 'package:flutter_verbos/widgets/loginButton.dart';
import 'package:flutter_verbos/widgets/textfield.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    dynamic altura = MediaQuery.of(context).size.height;

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    xis(){
       print("string é essa");    
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: altura * 0.05,),
              const Text("Bem-vindo", style: login,),
              SizedBox(height: altura * 0.12,),
              TextField(
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
              TextField(
                decoration: InputDecoration(
                  hintText: "Insira sua senha",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()
                ),
                controller: passwordController,
              ),
              SizedBox(height: altura * 0.1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Esqueceu a senha? ", style: TextStyle(color: Colors.white, fontSize: 20),),
                  const Text("GUILHERMEE", style: TextStyle(color: Color.fromARGB(255, 169, 36, 192),  fontSize: 23,),)
                ],
              ),
              SizedBox(height: altura * 0.1,),
              InkWell(
                onTap: () => {
                  print(emailController.text),
                   Navigator.push(
                    context, 
                    MaterialPageRoute(builder: ((context) => FeedPage() ))) 
                },
                child:   
                  Ink(
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    height: 70,
                    width: 500,
                    
                    child: Center(child: Text("Entrar", style: loginButtonText,),),
                ),
            ),
            SizedBox(height: altura * 0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não possui conta?", style: TextStyle(color: Colors.white, fontSize: 20),),
                InkWell(
                    onTap: () => {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: ((context) => RegisterPage() )))
                    },
                    child:   
                      Ink(
                        child:  Center(child: Text(" Cadastre-se", style: TextStyle(color: Color.fromARGB(255, 169, 36, 192),  fontSize: 23,)),),
                      ),
                )
              ],
            )
            ],
          ),
        ),
      )
    );
  }

}

