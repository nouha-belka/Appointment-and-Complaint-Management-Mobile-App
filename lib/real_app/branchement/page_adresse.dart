
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/branchement/progress_bar.dart';
import 'dart:math';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;
import 'formulair_page.dart';

class AdressePage extends StatefulWidget {
  const AdressePage({Key? key}) : super(key: key);

  @override
  _AdressePageState createState() => _AdressePageState();
}

class _AdressePageState extends State<AdressePage> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  var type_r = ['--Sélectionner--',"Ménage","Commerce","Industriel"];
  var type_b = ['--Sélectionner--',"Provisoire","Définitif"];
  String valueR = "--Sélectionner--";
  String valueB = "--Sélectionner--";
  late TextEditingController  adressCtrl;
  int? code;
  bool processing = false;
  Random random = new Random();
  void generateId() async{
    setState(() {
      processing = true;
    });
    var url = "http://${global.localhost}/php_project/web-flutter/ajouterCompteur.php";
    var data = {
      "adresse" : adressCtrl.text ,
      "code_client" : global.client_id,
      "typeB" : valueB[0] ,
      "typeR" : valueR[0],
    };
    var res = await http.post(Uri.parse(url),body: data);
    if(jsonDecode(res.body) != "false"){
      global.compteur_id = jsonDecode(res.body) ;
      print(global.compteur_id);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  FormulairPage()),
      );

    }else{
      print("fail");
    }
    setState(() {
      processing = false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    adressCtrl =  TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      resizeToAvoidBottomInset : false,
      backgroundColor: greyish,
      drawer: Menu(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: MediaQuery.of(context).size.height*0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 130,
                decoration: ContainerDeco,
                child: Center(child: ProgressBar(text:"Saisie adresse",getMenu: (){_scaffoldState.currentState!.openDrawer();},)),
              ),
              Container(
                height: 400,
                decoration: ContainerDeco,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: adressCtrl,
                      decoration: textInputDecoTrans.copyWith(
                        hintText: "Adress",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.grey[600],
                      ),
                        ),),
                      maxLines: 3,
                    ),
                    SizedBox(height: 7,),
                    textLable("Type de rejet"),
                    Container(
                      height: 60,
                      decoration: containerTrans,
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 13),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: valueR,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: mainColor,
                            size: 45,
                          ),
                          items: type_r.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style:TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              valueR = newValue!;
                            });
                          },
                          isExpanded : true,
                          itemHeight: 60,
                        ),
                      ),
                    ),
                    SizedBox(height: 7,),
                    textLable("Type de branchement"),
                    Container(
                      height: 60,
                      decoration: containerTrans,
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 13),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: valueB,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: mainColor,
                            size: 45,
                          ),
                          items: type_b.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style:TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              valueB = newValue!;
                            });
                          },
                          isExpanded : true,
                          itemHeight: 60,
                        ),
                      ),
                    ),
                  ],
                )

              ),
              ElevatedButton(
                onPressed:(){
                  generateId();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),)
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
                  child: processing == false ? Text(
                    "suivant",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ):spinkit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
