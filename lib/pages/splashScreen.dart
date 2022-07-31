import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verbos/pages/feedPage.dart';
import 'package:flutter_verbos/pages/initialPage.dart';
import 'package:flutter_verbos/pages/registerPage.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


import '../services/prefs_service.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      duration: 1500,
      backgroundColor: Colors.lightGreen,
      splashIconSize: 150,
      splash: Container(
        padding: EdgeInsets.all(20),
        child: Image.asset("assets/litKape.png"),
      ), 
      screenFunction: () async {
        return Future.wait([PrefsService.isAuth()]).then((value) {
          return value[0] ? FeedPage() : LoginScreen();
        });
      });
  }
}