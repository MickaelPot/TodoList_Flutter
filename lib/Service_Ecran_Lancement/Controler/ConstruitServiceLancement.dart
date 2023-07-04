import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_Ecran_Lancement/View/EcranLancement.dart';

import '../../Service_ToDo/Controler/ConstruitServiceTodo.dart';

class ServiceLancement extends StatelessWidget{
  ServiceLancement({Key? key})  :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      home: PageLancement()
    );
  }
}