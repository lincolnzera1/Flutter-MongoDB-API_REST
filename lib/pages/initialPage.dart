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

    // Verifica se email e senha foram encontrados no MONGODB
    Future logar() async {
      try {        
        
        List dados = await MongoDataBase.getData();
        var bytes = utf8.encode(passwordController.text);
        var digest = sha1.convert(bytes);
        for(var elementos in dados){
          if(emailController.text == elementos["email"] && digest.toString() == elementos["password"].toString()){
            
            //Salva o email e o nome de quem foi logado, no sharedPreferences.
            PrefsService.save(email: elementos["email"], name: elementos["nome"],);
            //print("logado!!!");
            Navigator.pushReplacementNamed(context, "/feed");
            return;// não sei o pq exatamente mas não deixa o resto do código executar.
          }
          
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar( backgroundColor: Colors.red, content: Text("Usuário não encontrado.")));
        
      }catch (e) {
        print("Error: $e");
      }
    }
  
    return Scaffold(
      //backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: altura,
          color: Colors.lightGreen,
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset("assets/litKape.png", height: altura*0.16,),
              Padding(padding: EdgeInsets.only(bottom: altura * 0.11)),
              Container( 
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: altura * 0.12,),
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Insira seu email",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder()
                      ),
                      controller: emailController,
                    ),
                    const SizedBox(height: 10,),            
                    TextField(
                      style: TextStyle(color: Colors.black),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        
                        hintText: "Insira sua senha",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder()
                      ),
                      controller: passwordController,
                    ),
                    SizedBox(height: altura * 0.07,),
                    InkWell(
                      onTap: () async {
                        await logar();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        height: 60,
                        width: 500,
                        child: const Center(child: Text("Entrar", style: loginButtonText,),),
                      ),
                  ),
                  SizedBox(height: altura * 0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Não possui conta?", style: TextStyle(color: Colors.black, fontSize: 18),),
                      InkWell(
                        onTap: ()  {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: ((context) => RegisterPage())
                            )
                          );
                        },
                        child: Ink(
                          child: const Center(child: Text(" Cadastre-se", style: TextStyle(color: Colors.red,  fontSize: 21, fontWeight: FontWeight.bold)),),
                        ),
                      ),
                    ],
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("Esqueceu a senha? ", style: TextStyle(color: Colors.black, fontSize: 17),),
                      SizedBox(height: 70,),
                      Text("JA ERA", style: TextStyle(color: Color.fromARGB(255, 217, 0, 255),  fontSize: 22,),)
                    ],
                  ), */
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
    
  }

  

}

