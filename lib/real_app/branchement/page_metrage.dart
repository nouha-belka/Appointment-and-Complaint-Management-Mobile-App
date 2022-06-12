import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/branchement/page_paiment.dart';
import 'package:trying_database_php/real_app/branchement/progress_bar.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;
class MetragePage extends StatefulWidget {
  const MetragePage({Key? key}) : super(key: key);

  @override
  _MetragePageState createState() => _MetragePageState();
}

class _MetragePageState extends State<MetragePage> {
  bool dateSet = true;
  String date = '0';
  String metrage = '0';
  String diametre = '0';
  TextStyle lableStyle = TextStyle(color: greyColor, fontSize: 25, );
  TextStyle textStyle = TextStyle(color: greyColor, fontSize: 18, fontWeight: FontWeight.w600);
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  void getDate()async{
    var url =
        "http://${global.localhost}/php_project/web-flutter/metrage_info.php";
    var data = {
      "code": global.compteur_id,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var response = jsonDecode(res.body);
    if(response == "false"){
      setState(() {
        dateSet = false;
      });
      print("false");
    }else{
      var map = HashMap.from(response);
      setState(() {
        dateSet = true;
        metrage = map["metrage"].toString();
        diametre = map["diametre"].toString();
        date = map["date"];
      });
      print(map);
    }
  }
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
  Widget metrageWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: MediaQuery.of(context).size.height*0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: Text(
                metrage == "0" ? "s'il vous plaît attendez jusqu'à ce que nous venions mesurer \nle: ${date}" : "Visite métrage  réalisé \nle: ${date} ",
              style: textStyle,
            ),
          ),
          returnTextContainer("Métrage","${metrage} m"),
          returnTextContainer("Diamètre","${diametre} m"),
          returnTextContainer("Agent","mouhamed"),

        ],
      ),
    );
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
                child: Center(child: ProgressBar(text:"Métrage",getMenu: (){_scaffoldState.currentState!.openDrawer();},round1: true,round2: true,)),
              ),
              Container(
                height: 400,
                decoration: ContainerDeco,
                child: dateSet == false ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                        "veuillez attendre jusqu'à ce que nous fixions une date de métrage ",
                      style: lableStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ) : metrageWidget() ,
              ),
              ElevatedButton(
                onPressed: metrage == "0" ? (){
                  Fluttertoast.showToast(msg: "veuillez attendre",toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                } : (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaimentPage()),
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
