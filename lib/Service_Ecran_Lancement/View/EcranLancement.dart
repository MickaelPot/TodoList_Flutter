import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_ToDo/Controler/ConstruitServiceTodo.dart';

class PageLancement extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 1000,
      splash: Image.asset('assets/images/comeon.png'),
      nextScreen: ServiceToDo(),
      splashTransition: SplashTransition.sizeTransition,
    );
  }


}