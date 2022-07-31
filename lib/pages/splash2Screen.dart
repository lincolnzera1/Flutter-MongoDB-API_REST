import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verbos/pages/initialPage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verbos/pages/splashScreen.dart';
import 'package:page_transition/page_transition.dart';

class splash2Screen extends StatefulWidget {
  const splash2Screen({ Key? key }) : super(key: key);

  @override
  State<splash2Screen> createState() => _splash2ScreenState();
}

class _splash2ScreenState extends State<splash2Screen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      duration: 1500,
      backgroundColor: Colors.lightGreen,
      splashIconSize: 150,
      splash: Container(
        padding: EdgeInsets.all(20),
        child: Image.asset("assets/botaoA.png"),
      ), 
      nextScreen: const SplashScreen() 
      );
  }
}