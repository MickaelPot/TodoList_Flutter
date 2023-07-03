import 'package:flutter/cupertino.dart';
import 'package:mickael_to_do/Service_ToDo/Model/Task.dart';
import '../Model/DAO.dart';

class GererLesTaches{
  static void ajoutTacheBDD(BuildContext context, int idTodo, String contenu) async {
    Task nouvelleTache = new Task.envoiBDD(idTodo, contenu);
    DAO dao = new DAO.constuctor();
    await dao.ajoutTask(nouvelleTache);
  }

  static void toggleAchevementTache(int idTask, int achevement){
    DAO dao = new DAO.constuctor();
    if(achevement==0){
      dao.rendTacheRealisee(idTask);
    }else{
      dao.rendTacheNonRealisee(idTask);
    }
  }

  static Future<List<Map<String, dynamic>>> recupereListeTachesAccomplies(int idTodo)  async {
    DAO dao = new DAO.constuctor();
    Future<List<Map<String, dynamic>>> futurRetour= dao.recupereToutesTachesAccomplies(idTodo);
    List<Map<String, dynamic>> retour=  await futurRetour;
    return retour;
  }

  static Future<List<Map<String, dynamic>>> recupereListeTachesNonAccomplies(int idTodo)  async {
    DAO dao = new DAO.constuctor();
    Future<List<Map<String, dynamic>>> futurRetour= dao.recupereToutesTachesNonAccomplies(idTodo);
    List<Map<String, dynamic>> retour=  await futurRetour;
    return retour;
  }
}