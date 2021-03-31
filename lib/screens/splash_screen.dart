import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:demo_altrumo/screens/main.dart';
import 'package:flutter/material.dart';

class SplashScreen
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          child: AnimatedSplashScreen(splash: Container(
              child: Image.asset("assets/altrumo.png",)), nextScreen: MainScreen(),
            splashTransition: SplashTransition.sizeTransition,duration: 3000,),
        ),
      ),
    );
  }
}
