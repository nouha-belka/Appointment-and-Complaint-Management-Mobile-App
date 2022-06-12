import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/reclamation/rec_constants.dart';
import 'package:trying_database_php/real_app/widgets/circle.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../library.dart' as global;


class ReclamationForm extends StatefulWidget {
  const ReclamationForm({Key? key}) : super(key: key);

  @override
  _ReclamationFormState createState() => _ReclamationFormState();
}

class _ReclamationFormState extends State<ReclamationForm> {


  CarouselController buttonCarouselController = CarouselController();
  String trying = "";
  bool round2 = false;
  double animationWidth2 = 0;
  double animationWidth3 = 0;
  double animationHeight = 20;
  Color animetionColor = Colors.black26;
  bool listIsChoosen = false;
  double containerWidth = 60;
  String buttonText = "Suivant";
  late TextEditingController detailsCtrl,factCtrl;
  bool processing = false;
  int choix = 0;
  String code_client = global.client_id;

  // List of items in our dropdown menu
  var items = [
    '--Sélectionner--',
    'Réclamations liées au compteur',
    'Réclamations ou demande liées à la facturation',
    'Réclamations liées au recouvrement',
    'Réclamations pour manque ou perturbation d\'eau',
    'Réclamations pour la qualité d\'eau',
    'Réclamations sur le comportement des équipes SEAAL',
    'Réclamations liées à l\'encaissement',
  ];
  var items2 = [
    '--Sélectionner--',
  ];
  var listCompteur = ['--Sélectionner--','122222','222'];
  String valeurCompteur = '--Sélectionner--';
  String dropdownvalue = '--Sélectionner--';
  String dropdownvalue2 = '--Sélectionner--';



  Widget optionsList(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: ContainerDeco,
        height: 330,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textLable("Domaines"),
                SizedBox(height: 7,),
                Container(
                  height: 60,
                  decoration: containerTrans,
                  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 13),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropdownvalue,
                      icon: const Icon(
                          Icons.arrow_drop_down,
                        color: mainColor,
                        size: 45,
                      ),
                      items: items.map((String items) {
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
                          dropdownvalue = newValue!;
                          int index = items.indexOf(dropdownvalue);
                          switch(index) {
                            case 1:
                              {
                                items2 = option1;
                                dropdownvalue2 = items2[0];
                                choix = 1;
                              }
                              break;

                            case 2:
                              {
                                items2 = option2;
                                dropdownvalue2 = items2[0];
                                choix = 2;
                              }
                              break;

                            case 3:
                              {
                                items2 = option3;
                                dropdownvalue2 = items2[0];
                                choix = 1;
                              }
                              break;

                            case 4:
                              {
                                items2 = option4;
                                dropdownvalue2 = items2[0];
                                choix = 1;
                              }
                              break;

                            case 5:
                              {
                                items2 = option5;
                                dropdownvalue2 = items2[0];
                                choix = 1;
                              }
                              break;

                            case 6:
                              {
                                items2 = option6;
                                dropdownvalue2 = items2[0];
                                choix = 3;
                              }
                              break;

                            case 7:
                              {
                                items2 = option7;
                                dropdownvalue2 = items2[0];
                                choix = 3;
                              }
                              break;
                            default:
                              {
                                items2 = [
                                  '--Sélectionner--',
                                ];
                                choix = 0;
                              }
                              break;
                          }

                        });
                      },
                      isExpanded : true,
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                textLable("Type de réclamations"),
                SizedBox(height: 7,),
                Container(
                  height: 60,
                  decoration: containerTrans,
                  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 13),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: dropdownvalue2,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: mainColor,
                        size: 45,
                      ),
                      items: items2.map((String items) {
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
                          dropdownvalue2 = newValue!;
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
      ),
    );
  }
  Widget details(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: ContainerDeco,
        height: 330,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                choix == 1 ? Column(
                  children: [
                    textLable("Code contrat"),
                    SizedBox(height: 7,),
                    Container(
                      height: 60,
                      decoration: containerTrans,
                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 13),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: valeurCompteur,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: mainColor,
                            size: 45,
                          ),
                          items: listCompteur.map((String items) {
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
                              valeurCompteur = newValue!;
                            });
                          },
                          isExpanded : true,
                          itemHeight: 60,
                        ),
                      ),
                    ),
                  ],
                ) : choix == 2 ? Column(
                  children: [
                    textLable("Numéro de facture"),
                    SizedBox(height: 7,),
                    TextField(
                      controller: factCtrl,
                      style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                      decoration: inputTrans,
                    ),
                  ],
                ) : Container(),
                SizedBox(height: 10,),
                textLable("Details"),
                SizedBox(height: 7,),
                TextField(
                  controller: detailsCtrl,
                  maxLines: 6,
                  style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                  decoration: inputTrans,
                ),

              ],
            )
        ),
      ),
    );
  }
  Widget message(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: ContainerDeco,
        height: 330,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "votre reclamation a été enregistré",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: greyColor, fontSize: 25, ),
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
  void sendRec() async{
    setState(() {
      processing = true;
    });
    int indexDomaine = items.indexOf(dropdownvalue);
    int indexType = items2.indexOf(dropdownvalue2);
    DateTime now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var data;
    var url = "http://${global.localhost}/php_project/web-flutter/ajouterRec.php";
    if(choix == 0){
      data = {
        "code_client" : code_client,
        "domaine" : "${indexDomaine}",
        "type" : "${indexType}",
        "details" : detailsCtrl.text,
        "date" : formattedDate,
        "code" : "null",
        "facture" : "null"
      };
    }else{
      if(choix == 1){
        data = {
          "code_client" : code_client,
          "domaine" : "${indexDomaine}",
          "type" : "${indexType}",
          "details" : detailsCtrl.text,
          "date" : formattedDate,
          "code" : valeurCompteur,
          "facture" : "null"
        };
      }else{
        data = {
          "code_client" : code_client,
          "domaine" : "${indexDomaine}",
          "type" : "${indexType}",
          "details" : detailsCtrl.text,
          "date" : formattedDate,
          "code" : "null",
          "facture" : factCtrl.text
        };
      }
    }


    var res = await http.post(Uri.parse(url),body: data);
    if(jsonDecode(res.body) == "true"){
      setState(() {
        animationWidth3 = 60;
        buttonText = "voir mes réclamations";
      });
      Fluttertoast.showToast(msg: "raison envoyé",toastLength: Toast.LENGTH_SHORT);
    }else{
      Fluttertoast.showToast(msg: "Error",toastLength: Toast.LENGTH_SHORT);
    }
    setState(() {
      processing = false;
    });
  }
  AppBar appBar = AppBar(
    backgroundColor: mainColor,
    title: Text(
      "Reclamation",
      style: TextStyle(color: Colors.white),
    ),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsCtrl =  TextEditingController();
    factCtrl =  TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    double height = appBar.preferredSize.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      drawer: Menu(),
      appBar: appBar,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - height - 20,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  decoration: ContainerDeco,
                  alignment: Alignment.center,
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(height: 5,color: mainColor ,width: 60,),
                      Circle(circleIcon: Icons.list_rounded,isFiniished: true,),
                      Container(
                          height: 5,
                          color:  Colors.black26,
                          width: containerWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                width: animationWidth2,
                                height: 5,
                                color: mainColor ,
                                duration: Duration(milliseconds: 250),
                              ),
                            ],
                          )
                      ),
                      Circle(circleIcon: Icons.drive_file_rename_outline,isFiniished: round2,),
                      Container(
                          height: 5,
                          color:  Colors.black26,
                          width: containerWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                width: animationWidth3,
                                height: 5,
                                color: mainColor ,
                                duration: Duration(milliseconds: 250),
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                animationWidth3 == 0 ?CarouselSlider(
                  options: CarouselOptions(
                    height: 330,
                    enableInfiniteScroll: false,
                    viewportFraction : 1,
                    autoPlay: false,
                    onPageChanged: (index,reason){
                      if(index == 0){
                        setState(() {
                          round2 = false;
                          animationWidth2 = 0;
                        });
                      }else{
                        if(index == 1){
                          setState(() {
                            buttonText = "Confirmer";
                            animationWidth2 = 60;
                          });
                          Future.delayed(Duration(milliseconds: 200), () {
                            setState(() {
                              round2 = true;
                            });
                          });
                        }
                      }
                    }
                  ),
                  carouselController: buttonCarouselController,
                  items: [1,2].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        if(i == 1){
                          return optionsList();
                        }else{
                          if(i == 2 ){
                            return details();
                          }
                          return Text("hello");
                        }
                      },
                    );
                  }).toList(),
                ) : message(),
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0),)
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                    ),
                    onPressed: ()async{
                      if(buttonText == "Suivant"){
                        buttonCarouselController.nextPage(
                            duration: Duration(milliseconds: 250), curve: Curves.linear);
                      }else{
                        if(buttonText == "Confirmer"){
                          if( dropdownvalue ==  "--Sélectionner--" || dropdownvalue2 == "--Sélectionner--" || detailsCtrl.text == "" || (choix == 1 && valeurCompteur == "--Sélectionner--" ) || (choix == 2 && factCtrl.text == "") ){
                            Fluttertoast.showToast(msg: "veuillez remplir tout les champs",toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                          }else{
                            processing == false ? sendRec() : null;
                          }
                        }else{
                          //puch to list rec
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 10, 60, 10),
                      child: processing == false ? Text(
                        buttonText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ) : spinkit,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
