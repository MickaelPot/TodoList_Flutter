class Task{
  int ?idTask;
  int ?idTodo;
  String ?contenu;
  int ?acheve;

  Task(int this.idTask, int this.idTodo, String this.contenu, int this.acheve);

  Task.envoiBDD(int idTodo, String contenu){
    this.idTodo=idTodo;
    this.contenu=contenu;
    this.acheve=0;
  }

  Map<String, dynamic> convertiObjEnMap(){
    return{
      "idTask": this.idTask,
      "idTodo": this.idTodo,
      "contenu": this.contenu,
      "acheve": this.acheve
    };
  }
}