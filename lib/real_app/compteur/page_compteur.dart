import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/branchement/formulair_page.dart';
import 'package:trying_database_php/real_app/branchement/page_adresse.dart';
import 'package:trying_database_php/real_app/compteur/comp_tile.dart';
import 'package:trying_database_php/real_app/compteur/compteur.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import 'dart:convert';
import 'dart:collection';
import 'package:http/http.dart' as http;
import '../library.dart' as global;

class PageCompteur extends StatefulWidget {
  const PageCompteur({Key? key}) : super(key: key);

  @override
  _PageCompteurState createState() => _PageCompteurState();
}

class _PageCompteurState extends State<PageCompteur> {
  List<Compteur> comps = [];
  void getList() async{
    var url = "http://${global.localhost}/php_project/web-flutter/list_compteur.php";
    var data = {
      "code_client_rech" : global.client_id,
    };
    var res = await http.post(Uri.parse(url),body: data);
    //var res = await http.get(Uri.parse(url));
    var reasonsList =  jsonDecode(res.body);
    setState(() {
      comps= [];
    });
    print(res);
    for(var i = 0; i < reasonsList.length; i++){
      var map = HashMap.from((reasonsList[i]));
      setState(() {
        comps.add(Compteur(id: map['code_comp'],adresse: map['adresse'],etat: map['etat']),);
      });
      print(map);
    }
  }@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyish,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Mes Compteur",
          style: TextStyle(color: Colors.white, fontFamily: 'MPLUS'),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  AdressePage()),
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: Text(
              'Ajouter',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ],
      ),
      drawer: Menu(),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          // height: MediaQuery.of(context).size.height,
          child: comps.length > 0 ? ListView(
            children: comps.map((comp){
              return CompTile(comp: comp,);
            } ).toList(),): Center(child: Text("vous n'avez pas de compte", style: TextStyle(fontSize: 25,color: textColor),),)
      ),
    );
  }
}
