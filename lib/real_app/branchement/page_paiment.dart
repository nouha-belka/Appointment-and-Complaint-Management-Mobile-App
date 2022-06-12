import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/branchement/page_branchement.dart';
import 'package:trying_database_php/real_app/branchement/progress_bar.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;
class PaimentPage extends StatefulWidget {
  const PaimentPage({Key? key}) : super(key: key);

  @override
  _PaimentPageState createState() => _PaimentPageState();
}

class _PaimentPageState extends State<PaimentPage> {
  String? montant = "null" ;
  String etat_payment = "date de branchement pas encore fixé";
  TextStyle lableStyle = TextStyle(color: greyColor, fontSize: 25, );
  TextStyle textStyle = TextStyle(color: greyColor, fontSize: 18, fontWeight: FontWeight.w600);
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  Widget returnTextContainer(String label,String fill){
    TextStyle lableStyle = TextStyle(color: greyColor, fontSize: 17, fontWeight: FontWeight.w600);
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: lableStyle,
            textAlign: TextAlign.start,
          ),
          SizedBox(height:MediaQuery.of(context).size.height*0.012 ,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
              color: greyish,
              borderRadius: BorderRadius.all(Radius.circular(10),),
            ),
            child: Text(
              fill,
              textAlign: TextAlign.start,
              style: lableStyle,

            ),
          )
        ],
      ),
    );
  }

  Widget paimentWidget(){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: MediaQuery.of(context).size.height*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Text(
              "cher client veuillez venir payer pour continuer la procédure d'installation de compteur ",
              style: textStyle,
            ),
          ),
          returnTextContainer("code client","${global.client_id}"),
          returnTextContainer("Montant","${montant!} DA"),

        ],
      ),
    );
  }
  Widget centerWidget(String text){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Text(
          text,
          style: lableStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Widget screenWidget(){
    return etat_payment == "date de branchement pas encore fixé" ? centerWidget("Cher client nous vous informons que votre paiement a bien été enregisté")
        : paimentWidget();
  }



  void getPay()async{
    var url =
        "http://${global.localhost}/php_project/web-flutter/payment.php";
    var data = {
      "code": global.compteur_id,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var response = jsonDecode(res.body);
    if(response == "false"){
      // print("false");
    }else{
      var map = HashMap.from(response);
      setState(() {
        montant = map["montant"].toString();
        etat_payment = map["etat"];
      });
      // print(montant == "null");
      // print(etat_payment);
    }
  }

  @override
  void initState() {
    super.initState();
    getPay();
  }
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
                child: Center(child: ProgressBar(text:"Paiment",getMenu: (){_scaffoldState.currentState!.openDrawer();},round1: true,round2: true,round3: true)),
              ),
              Container(
                height: 400,
                decoration: ContainerDeco,
                child: montant == "null" ? centerWidget("Cher client, nous vous informons que les mesures ont été prises, le prix de votre branchement vous sera communiquée dans les plus brefs délais.")
                    : screenWidget(),
              ),
              ElevatedButton(
                onPressed: montant == "null" ? (){
                  Fluttertoast.showToast(msg: "veuillez attendre",toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                } : etat_payment == "prix fixé en attente de paiement" ? (){
                  Fluttertoast.showToast(msg: "veuillez venir payer",toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                } : (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BranchementPage()),
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),)
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 10),
                  child: Text(
                    "suivant",
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

