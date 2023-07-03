import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mickael_to_do/Service_ToDo/Controler/GererLesTaches.dart';
import '../Model/Composants/PopUp.dart';
import '../Services/configuration.dart';

class PageTask extends StatefulWidget {
  const PageTask({Key? key}) : super(key: key);

  @override
  State<PageTask> createState() => StatePageTask();
}

class StatePageTask extends State<PageTask>{
  late TextEditingController texteSaisi;

  @override
  void initState() {
    super.initState();
    texteSaisi=TextEditingController();
  }

  recupereEnsembleTaches(int idTodo) async{
     return await GererLesTaches.recupereListeTachesAccomplies(idTodo);
  }

  @override
  void dispose(){
    texteSaisi.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final dynamic idTodo = ModalRoute.of(context)!.settings.arguments;
    late Future<List<Map<String, dynamic>>> listeTasks=GererLesTaches.recupereListeTachesAccomplies(idTodo);
    late Future<List<Map<String, dynamic>>> listeTasksRealisees=GererLesTaches.recupereListeTachesNonAccomplies(idTodo);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(
                  margin: EdgeInsets.only(
                    top: 50
                  ),
                    child: Text(
                      Configuration.VG_Tache_Non_Realisee,
                      style: GoogleFonts.ysabeau(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    )

            ),
            Container(
              child: FutureBuilder(
                future: listeTasks,
                builder: (context, AsyncSnapshot <List<Map<String, dynamic>>> data){
                  if(!data.hasData || data.data ==null){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(data.data!.length ==0){
                    return Center();
                  }else{
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.data?.length,
                        itemBuilder: (context,index){
                          int idTask= data.data![index]["idTask"].toInt();
                          int acheve=data.data![index]["acheve"].toInt();
                          String contenu= data.data![index]["contenu"].toString();
                          return Dismissible(
                              key: ValueKey<int>(idTask),
                              child: GestureDetector(
                                onTap: (){
                                  //Changer la tâche en achevée
                                  setState(() {
                                    GererLesTaches.toggleAchevementTache(idTask, acheve);
                                  });
                                },
                                child: Container(
                                  margin:EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.systemGrey6,
                                      boxShadow: [
                                        BoxShadow(
                                            color: CupertinoColors.systemGrey,
                                            blurRadius: 4,
                                            spreadRadius: 1
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.all(10),
                                        title: Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              contenu,
                                              style: GoogleFonts.ysabeau(
                                                  fontSize: 26
                                              ),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          );
                        }
                    );
                  }
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 50
                ),
                child: Text(
                  Configuration.VG_Tache_Realisee,
                  style: GoogleFonts.ysabeau(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                )

            ),
            Container(
              child: FutureBuilder(
                future: listeTasksRealisees,
                builder: (context, AsyncSnapshot <List<Map<String, dynamic>>> data){
                  if(!data.hasData || data.data ==null){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(data.data!.length ==0){
                    return Center(
                      child: Container(

                      ),
                    );
                  }else{
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.data?.length,
                        itemBuilder: (context,index){
                          int idTask= data.data![index]["idTask"].toInt();
                          int acheve=data.data![index]["acheve"].toInt();
                          String contenu= data.data![index]["contenu"].toString();
                          return Dismissible(
                              key: ValueKey<int>(idTask),
                              child: GestureDetector(
                                onTap: (){
                                  //Changer la tâche en non achevée
                                  setState(() {
                                    GererLesTaches.toggleAchevementTache(idTask, acheve);
                                  });
                                },
                                child: Container(
                                  margin:EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      boxShadow: [
                                        BoxShadow(
                                            color: CupertinoColors.systemGrey,
                                            blurRadius: 4,
                                            spreadRadius: 1
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.all(10),
                                        title: Padding(
                                            padding: EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              contenu,
                                              style: GoogleFonts.ysabeau(
                                                  fontSize: 26
                                              ),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                          );
                        }
                    );
                  }
                },
              ),
            )
          ],
        ) ,
      )
      ,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex : 0,
          items : [
            BottomNavigationBarItem(
              label  : "Ajouter une tâche",
              icon  : Icon(Icons.add_comment),
            ),

            BottomNavigationBarItem(
              label  : "retour",
              icon  : Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ],
          onTap  : (int index) {
            switch(index){
              case 0:
                  PopUp popUpAjout= new PopUp(context);
                  popUpAjout.popUpAjoutTask(texteSaisi,idTodo);
                break;
              case 1:
                Navigator.of(context).pushNamed("/");
            }
          }),
    );
  }
}