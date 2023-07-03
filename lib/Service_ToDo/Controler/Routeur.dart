import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_ToDo/Controler/GererLesTodos.dart';
import 'package:mickael_to_do/Service_ToDo/View/PageTask.dart';
import 'package:mickael_to_do/Service_ToDo/View/pageTodo.dart';

class Routeur{
  static const String pageTodo="/";
  static const String pageTask="/task";

  static Route creerLesRoutes(RouteSettings proprietes)  {
    switch (proprietes.name) {
      case pageTodo:
        return MaterialPageRoute(
          settings: proprietes,
          builder: (_)  =>
            PageTodo()
        );
      case pageTask:
        return MaterialPageRoute(
          settings: proprietes,
          builder: (_) => PageTask(),
        );
      default:
        return MaterialPageRoute(
          settings: proprietes,
          builder: (_) => PageTodo(),
        );
    }
  }
}