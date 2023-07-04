import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_Ecran_Lancement/Controler/ConstruitServiceLancement.dart';
import 'package:mickael_to_do/Service_ToDo/Controler/ConstruitServiceTodo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Lancement de l'application
  runApp(ServiceLancement());
}