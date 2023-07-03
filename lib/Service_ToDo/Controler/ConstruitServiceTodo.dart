import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../View/PageTask.dart';
import '../View/pageTodo.dart';
import 'Routeur.dart';



class ServiceToDo extends StatelessWidget{
   ServiceToDo({Key? key})  :
          super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: Routeur.creerLesRoutes,
        initialRoute: '/',
        routes: {
          '/': (context) => PageTodo(),
          '/task': (context) => PageTask(),
        });
  }}