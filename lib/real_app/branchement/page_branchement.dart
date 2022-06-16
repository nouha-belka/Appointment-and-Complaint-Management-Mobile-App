import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/branchement/progress_bar.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;

class BranchementPage extends StatefulWidget {
  const BranchementPage({Key? key}) : super(key: key);

  @override
  _BranchementPageState createState() => _BranchementPageState();
}



class _BranchementPageState extends State<BranchementPage> {
  String date = "null" ;
  String? codeComp;
  String agent = "";
  String etat = "en attente de branchement";
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

  Widget screenWidget(){
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: MediaQuery.of(context).size.height*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Text(
              etat == "en attente de branchement" ? "Branchement prévu pour le: ${date} " : "Branchement réalisé le: ${date}" ,
              style: textStyle,
            ),
          ),
          // returnTextContainer("Agent","${codeComp}"),
          returnTextContainer("Agent",agent),
          returnTextContainer("Code compteur","${codeComp}"),
        ],
      ),
    );
  }

  void getDate()async{
    var url =
        "http://${global.localhost}/php_project/web-flutter/branchement.php";
    var data = {
      "code": global.compteur_id,
      // "code": "22MDAA01",
    };
    var res = await http.post(Uri.parse(url), body: data);
    var response = jsonDecode(res.body);
    if(response == "false"){
      // print("false");
    }else{
      var map = HashMap.from(response);
      setState(() {
        date = map["date"].toString();
        etat = map["etat"];
        codeComp = map["CodeComp"];
        agent = map["emp"];
      });
      print(map);
      // print(montant == "null");
      // print(etat_payment);
    }
  }
  @override
  void initState() {
    super.initState();
    getDate();
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
                child: Center(child: ProgressBar(text:"Branchement",getMenu: (){_scaffoldState.currentState!.openDrawer();},round1: true,round2: true,round3: true,round4: true,round5: etat == "en attente de branchement" ? false : true,)),
              ),
              Container(
                height: 400,
                decoration: ContainerDeco,
                child: date == "null" ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      "une date de realisation vous sera comuniqué dans les plus bref delais",
                      style: lableStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : screenWidget(),
              ),
              ElevatedButton(
                onPressed: date == "null" || etat == "en attente de branchement" ? (){
                  Fluttertoast.showToast(msg: "veuillez attendre",toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                }  : (){
                  print("suivant");
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
