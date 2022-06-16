import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:collection';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/rendezVous/en_attente_tile.dart';
import 'package:trying_database_php/real_app/rendezVous/raison.dart';
import 'package:trying_database_php/real_app/rendezVous/rd_tile.dart';
import 'package:trying_database_php/real_app/rendezVous/rendez_vous.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;
class EnAttente extends StatefulWidget {
  const EnAttente({Key? key}) : super(key: key);

  @override
  _EnAttenteState createState() => _EnAttenteState();
}

class _EnAttenteState extends State<EnAttente> {
  bool color1 = true, color2 = false,color3 = false, color4 = false,color5 = false,color6 = false;
  List<Raison> raisons= [];
  List<RendezVous> rendezVouss= [];
  void getList(String page) async{
    var url = "http://${global.localhost}/php_project/web-flutter/list_raison.php";
    var data = {
      "code_client_rech" : global.client_id,
      "page" : page
    };
    var res = await http.post(Uri.parse(url),body: data);
    //var res = await http.get(Uri.parse(url));
    var reasonsList =  jsonDecode(res.body);
    if(page == 'attente' || page == 'refus' ){
      setState(() {
        raisons= [];
      });
      for(var i = 0; i < reasonsList.length; i++){
        var map = HashMap.from((reasonsList[i]));
        setState(() {
          raisons.add(Raison(sujet: map['subject'], description: map['content'], etat: map['state'], justification: map['just']),);
        });
      }

    }else{
      if(page == 'rd' || page == 'fait' || page == 'annulé'){
        setState(() {
          rendezVouss= [];
        });
        for(var i = 0; i < reasonsList.length; i++){
          var map = HashMap.from((reasonsList[i]));
          setState(() {
            rendezVouss.add(RendezVous(id: map['id'],sujet: map['subject'], description: map['content'], date: map['date'],heure: map['heure'],agent: map['agent']),);
          });

        }
      }
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList("attente");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: Text(
          "Rendez-vous",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      drawer: Menu(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
              decoration: ContainerDeco,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){setState(() {
                      if(!color1){
                        getList("attente");
                      }
                      color1 = true; color2 = false;color3 = false; color4 = false;color5 = false;color6 = false;

                    });},
                    child: Column(
                      children: [
                        Text("en attente",style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 20,fontWeight: FontWeight.bold),),
                        Container(
                          color: color1? mainColor : Colors.transparent,
                          height: 3,
                          width: 90,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){setState(() {
                      if(!color2){
                        getList("rd");
                      }
                      color1 = false; color2 = true;color3 = false; color4 = false;color5 = false;color6 = false;
                    });},
                    child: Column(
                      children: [
                        Text("planifié",style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 20,fontWeight: FontWeight.bold),),
                        Container(
                          color: color2? mainColor : Colors.transparent,
                          height: 3,
                          width: 90,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){setState(() {
                      if(!color3){
                        getList("refus");
                      }
                      color1 = false; color2 = false;color3 = true; color4 = true;color5 = false;color6 = false;

                    });},
                    child: Column(
                      children: [
                        Text("Terminé",style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 20,fontWeight: FontWeight.bold),),
                        Container(
                          color: color3? mainColor : Colors.transparent,
                          height: 3,
                          width: 90,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            color3 ? Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                decoration: ContainerDeco,
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){setState(() {
                        if(!color4){
                          getList("refus");
                        }
                        color1 = false; color2 = false; color4 = true;color5 = false;color6 = false;

                      });},
                      child: Column(
                        children: [
                          Text("refusé",style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 18,fontWeight: FontWeight.bold),),
                          Container(
                            color: color4? mainColor : Colors.transparent,
                            height: 3,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){setState(() {
                        if(!color5){
                          getList("annulé");
                        }
                        color1 = false; color2 = false; color4 = false;color5 = true;color6 = false;
                      });},
                      child: Column(
                        children: [
                          Text("annulé",style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 18,fontWeight: FontWeight.bold),),
                          Container(
                            color: color5? mainColor : Colors.transparent,
                            height: 3,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){setState(() {
                        if(!color6){
                          getList("fait");
                        }
                        color1 = false; color2 = false; color4 = false;color5 = false;color6 = true;


                      });},
                      child: Column(
                        children: [
                          Text("fait",style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 18,fontWeight: FontWeight.bold),),
                          Container(
                            color: color6? mainColor : Colors.transparent,
                            height: 3,
                            width: 80,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ) : Container(),
            Container(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
              decoration: ContainerDeco,
              height: color3 ? MediaQuery.of(context).size.height*0.63  : MediaQuery.of(context).size.height*0.72,
              child: color1 || color4  ? ListView(
                children: raisons.map((raison){
                  return RaisonTile(raison: raison, page: color1,);
                } ).toList(),
              ):  ListView(
                children: rendezVouss.map((rd){
                  return RdTile(rendezVous: rd,);
                } ).toList(),
              )
            )
          ],
        ),
      ),
    );
  }


}
