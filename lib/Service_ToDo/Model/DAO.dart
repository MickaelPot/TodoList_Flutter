import 'dart:async';
import 'package:mickael_to_do/Service_ToDo/Model/Todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Task.dart';

class DAO{
  String nomTableTodo="todo";
  String nomTableTask="task";
  String nomFichierBDD="Todos.db";

  DAO.constuctor();
  static final DAO instance = DAO.constuctor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  _initiateDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, this.nomFichierBDD);
    return await openDatabase(path, version: 1, onCreate: creerTables);
  }


  Future creerTables(Database db, int version) async {
    this.creerTableTodo(db, version);
    this.creerTableTask(db, version);
  }

  Future creerTableTodo(Database db, int version) async{
    String requete= 'CREATE TABLE todo (idTodo INTEGER PRIMARY KEY AUTOINCREMENT, Titre TEXT NOT NULL)';
    await db.execute(requete);
  }

  Future creerTableTask(Database db, int version) async{
    String requete= 'CREATE TABLE task (idTask INTEGER PRIMARY KEY AUTOINCREMENT, idTodo INTEGER NOT NULL, contenu TEXT NOT NULL, acheve INTEGER NPT NULL, FOREIGN KEY(idTodo) REFERENCES todo(idTodo))';
    await db.execute(requete);
  }

  Future<int> ajoutTodo(Todo todo_actuel) async {
    Database db = await instance.database;
    return await db.insert(this.nomTableTodo,todo_actuel.convertiObjEnMap());
  }

  Future<List<Map<String, dynamic>>> recupereTousTodos() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps= await db.query(this.nomTableTodo);
    return maps;
  }

  Future<int> ajoutTask(Task tache) async {
    Database db = await instance.database;
    return await db.insert(this.nomTableTask,tache.convertiObjEnMap());
  }

  Future<List<Map<String, dynamic>>> recupereToutesTachesAccomplies(int idTodo) async {
    Database db = await instance.database;
    String requete= "SELECT * FROM task WHERE idTodo= ? AND acheve=? ;";
    final List<Map<String, dynamic>> maps= await db.rawQuery(requete,[idTodo, 0]);
    return maps;
  }

  Future<List<Map<String, dynamic>>> recupereToutesTachesNonAccomplies(int idTodo) async {
    Database db = await instance.database;
    String requete= "SELECT * FROM task WHERE idTodo= ? AND acheve=? ;";
    final List<Map<String, dynamic>> maps= await db.rawQuery(requete,[idTodo, 1]);
    return maps;
  }

  Future<void> rendTacheRealisee(int idTask) async {
    Database db = await instance.database;
    String requete= "UPDATE task SET acheve = 1 WHERE idTask =? ;";
    await db.rawQuery(requete,[idTask]);
  }

  Future<void> rendTacheNonRealisee(int idTask) async {
    Database db = await instance.database;
    String requete= "UPDATE task SET acheve = 0 WHERE idTask =? ;";
    await db.rawQuery(requete,[idTask]);
  }

  Future<int> calculePourcentageAccomplissement(int idTodo) async{
    Database db = await instance.database;
    String requeteAll= "SELECT count(*) FROM task WHERE idTodo= ?;";
    String requeteTachesAccomplies= "SELECT count(*) FROM task WHERE idTodo= ? AND acheve=1;";
    var compterNombreTache= await db.rawQuery(requeteAll,[idTodo]);
    var compterNbTachesAccomplies= await db.rawQuery(requeteTachesAccomplies,[idTodo]);
    //Parser le resultat en int
    String stringCompterNbTaches= compterNbTachesAccomplies[0]["count(*)"].toString();
    int intCompterNbTaches=  int.parse(stringCompterNbTaches);
    String stringCompterNbTachesTotales= compterNombreTache[0]["count(*)"].toString();
    int intCompterNbTachesTotales=  int.parse(stringCompterNbTachesTotales);

    if(intCompterNbTachesTotales==0){
      return 0;
    }else{
      return ((intCompterNbTaches / intCompterNbTachesTotales) * 100).round();
    }
  }

}