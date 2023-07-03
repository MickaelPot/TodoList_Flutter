import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_ToDo/Controler/GererLesTaches.dart';
import '../../Controler/GererLesTodos.dart';

class PopUp{
  late BuildContext context;

  PopUp(BuildContext context) {
    this.context=context;
  }

  PopUpErreur(String messageErreur){
    showDialog(
      context: this.context,
      builder: (context) => AlertDialog(
        title: Text(messageErreur),
        actions: [
          TextButton(
              child:Text("OK"),
              onPressed: (){
                Navigator.of(context).pushNamed("/");
              }
          ),
        ],
      ),
    );
  }

  PopUpAjoutTodo(TextEditingController texte){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Saisissez le nom du Todo"),
        content:TextField(
          controller: texte,
          autofocus: true,
        ),
        actions: [
          TextButton(
              child:Text("ANNULER"),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          TextButton(
              child:Text("AJOUTER"),
              onPressed: (){
                GererLesTodos.ajoutTodoBDD(context, texte.text);
              }
          ),
        ],
      ),
    );
  }

  popUpAjoutTask(TextEditingController texte, int idTodo){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Enregistrer une tâche"),
        content:TextField(
          controller: texte,
          autofocus: true,
        ),
        actions: [
          TextButton(
              child:Text("ANNULER"),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          TextButton(
              child:Text("AJOUTER"),
              onPressed: (){
                GererLesTaches.ajoutTacheBDD(context, idTodo, texte.text);
                Navigator.of(context).pushNamed("/task", arguments: idTodo);
              }
          ),
        ],
      ),
    );
  }
}