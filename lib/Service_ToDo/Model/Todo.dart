class Todo{
  int ?idTodo;
  String titre;

  Todo(int this.idTodo, String this.titre);

  //Constructeur qui permet de gerer l'auto incrementation de la base de données
  Todo.envoiBDD(String this.titre);

  Map<String, dynamic> convertiObjEnMap(){
    return{
      "idTodo": this.idTodo,
      "titre": this.titre
    };
  }
}
