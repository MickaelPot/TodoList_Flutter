import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_ToDo/Model/DAO.dart';
import 'package:mickael_to_do/Service_ToDo/Model/Composants/PopUp.dart';
import 'package:mickael_to_do/Service_ToDo/Model/Todo.dart';
import 'package:mickael_to_do/Service_ToDo/Services/configuration.dart';

class GererLesTodos{
  static void ajoutTodoBDD(BuildContext context, String titre) async{
    Todo nouveauTodo = new Todo.envoiBDD(titre);
    DAO dao = new DAO.constuctor();
    if(await dao.ajoutTodo(nouveauTodo)==0){
      //Erreur à l'insertion dans la base
      PopUp erreur = new PopUp(context);
      erreur.PopUpErreur(Configuration.VG_messageErreur);
    }else{
      Navigator.of(context).pushNamed("/");
    }
  }

  static Future<List<Map<String, dynamic>>> recupereListeTodos()  async {
      DAO dao = new DAO.constuctor();
      Future<List<Map<String, dynamic>>> futurRetour= dao.recupereTousTodos();
      List<Map<String, dynamic>> retour=  await futurRetour;
      List<Map<String, dynamic>> construction= [];
      int compteur=0;
      for(var element in retour){
        if(element.keys.contains("idTodo")){
          int resultat= await calculeAccomplissement(element["idTodo"]);
          String pourcentage= resultat.toString()+"% réalisé";
          Map<String, dynamic> map={"idTodo":retour[compteur]["idTodo"],"Titre":retour[compteur]["Titre"],"pourcentage":pourcentage};
          construction.add(map);
          compteur++;
        }
      }
      return await construction;
  }

  static Future<int> calculeAccomplissement(int idTodo) async{
    DAO dao = new DAO.constuctor();
    Future<int> resultat= dao.calculePourcentageAccomplissement(idTodo);
    return resultat;
  }
}