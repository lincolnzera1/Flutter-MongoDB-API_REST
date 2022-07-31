import 'package:flutter/material.dart';
import 'package:flutter_verbos/dbHelper/mongodb.dart';
import 'package:flutter_verbos/pages/feedPage.dart';
import 'package:flutter_verbos/pages/registerPage.dart';
import 'package:flutter_verbos/services/prefs_service.dart';
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

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }
  

  @override
  Widget build(BuildContext context) {

    dynamic altura = MediaQuery.of(context).size.height;

    

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
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
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
                style: TextStyle(color: Colors.white),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  
                  hintText: "Insira sua senha",
                  hintStyle: TextStyle(color: Colors.white),
                  labelText: "Senha",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()
                ),
                controller: passwordController,
              ),
              SizedBox(height: altura * 0.07,),
              
              SizedBox(height: altura * 0.07,),
              InkWell(
                onTap: () async {
                  await logar();
                },
                child: Ink(
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
                        child:  Center(child: Text(" Cadastre-se", style: TextStyle(color: Color.fromARGB(255, 217, 0, 255),  fontSize: 23,)),),
                      ),
                ),
            
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Esqueceu a senha? ", style: TextStyle(color: Colors.white, fontSize: 17),),
                SizedBox(height: 70,),
                Text("JA ERA", style: TextStyle(color: Color.fromARGB(255, 217, 0, 255),  fontSize: 22,),)
              ],
            ),
            ],
          ),
        ),
      )
    );
  }

  // Verifica se email e senha forem encontrados no MONGODB
  Future logar() async {
    try {        
      
      List dados = await MongoDataBase.getData();
      var bytes = utf8.encode(passwordController.text);
      var digest = sha1.convert(bytes);
      for(var elementos in dados){
        if(emailController.text == elementos["email"] && digest.toString() == elementos["password"].toString()){
          PrefsService.save(elementos["email"]);
          print("logado!!!");
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const FeedPage()));
          return; // não sei o pq exatamente mas não deixa o resto do código executar.
        }
        
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar( backgroundColor: Colors.red, content: Text("Usuário não encontrado.")));
      
    }catch (e) {
      print("Error: $e");
    }
  }

}

