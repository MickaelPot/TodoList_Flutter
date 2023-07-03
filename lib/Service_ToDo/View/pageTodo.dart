import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mickael_to_do/Service_ToDo/Controler/GererLesTodos.dart';
import 'package:mickael_to_do/Service_ToDo/Services/configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Model/Composants/PopUp.dart';

class PageTodo extends StatefulWidget {
  const PageTodo({Key? key}) : super(key: key);

  @override
  State<PageTodo> createState() => StatePageTodo();
}

class StatePageTodo extends State<PageTodo>{
  late TextEditingController texteSaisi;
  late Future<List<Map<String, dynamic>>> listeTodos;

  @override
  void initState() {
    super.initState();
    texteSaisi=TextEditingController();
    recupereEnsembleTodos();
  }

  recupereEnsembleTodos() async{
    this.listeTodos=  GererLesTodos.recupereListeTodos();
  }

  @override
  void dispose(){
    texteSaisi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white70,
                Colors.white10
              ]
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 80,
                    margin: EdgeInsets.only(
                      top: 0, bottom: 15

                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.elliptical(500, 300),
                        bottomRight: Radius.elliptical(500, 300),
                      )
                    ),
                    child: Text(
                      Configuration.VG_Titre_app,
                      style: GoogleFonts.permanentMarker(
                        fontSize: 50,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                        child: FutureBuilder(
                          future:listeTodos,
                          builder: (context, AsyncSnapshot <List<Map<String, dynamic>>> data){
                            if(!data.hasData || data.data ==null){
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }else if(data.data!.length ==0){
                              return Center(
                                child: Container(
                                    margin: EdgeInsets.all(50),
                                    height: 500,
                                    width: 300,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child:  Text(
                                        Configuration.VG_Todo_Null,
                                        style: GoogleFonts.permanentMarker(
                                            fontSize: 30,
                                            color: Colors.black
                                        ),
                                      ),
                                    )
                                ),
                              );
                            }else{
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.data?.length,
                                  itemBuilder: (context,index){
                                    int idTodo=data.data![index]["idTodo"].toInt();
                                    String stringTodo= data.data![index]["Titre"].toString();
                                    String pourcentage= data.data![index]["pourcentage"].toString();
                                    return Dismissible(
                                        key: ValueKey<int>(idTodo),
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).pushNamed("/task", arguments: idTodo);
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
                                                      padding: EdgeInsets.only(bottom: 1),
                                                      child: Text(
                                                        stringTodo,
                                                        style: GoogleFonts.ysabeau(
                                                            fontSize: 26
                                                        ),
                                                      )
                                                  ),
                                                ),

                                                ListTile(
                                                  contentPadding: EdgeInsets.all(10),
                                                  title: Text(
                                                        pourcentage,
                                                        style: GoogleFonts.ysabeau(
                                                            fontSize: 20
                                                        ),
                                                    textAlign: TextAlign.right,
                                                      )
                                                  ),
                                              ],
                                            ),
                                          ),
                                        )
                                    );
                                  }
                              );
                            }
                          },
                        )
                    ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex : 0,
        items : [
            BottomNavigationBarItem(
              label  : "Creer un Todo",
              icon  : Icon(Icons.add_circle_outline),
            ),
          BottomNavigationBarItem(
            label  : "Supprimer un Todo",
            icon  : Icon(Icons.remove_circle_outline),
          ),
          ],
          onTap  : (int index) {
              switch(index){
                case 0:
                  PopUp popUpAjout= new PopUp(context);
                  popUpAjout.PopUpAjoutTodo(texteSaisi);
                break;
              }
          }),
    );
  }
}
