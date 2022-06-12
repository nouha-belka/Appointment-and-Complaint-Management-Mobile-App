import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'dart:convert';
import '../library.dart' as global;
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/pages/form_page.dart';
class Confirmer extends StatefulWidget {
  String nom,prenom,date,tel,email,code;
  Confirmer({required this.code,required this.nom,required this.prenom,required this.date,required this.tel,required this.email});

  @override
  _ConfirmerState createState() => _ConfirmerState(code: this.code,nom: this.nom,prenom: this.prenom,date: this.date,tel: this.tel,email: this.email);
}

class _ConfirmerState extends State<Confirmer> {
  String nom,prenom,date,tel,email,code;
  _ConfirmerState({required this.code,required this.nom,required this.prenom,required this.date,required this.tel,required this.email});


  TextStyle lableStyle = TextStyle(color: greyColor, fontSize: 22, );
  // String code = "123456789";
  late TextEditingController passCtrl, passConCtrl;
  bool processing = false;
  void ajouterClient() async{
    setState(() {
      processing = true;
    });
    var url = "http://${global.localhost}/php_project/web-flutter/ajouterClient.php";
    var data = {
      "code" : code ,
      "nom" : nom ,
      "prenom" : prenom ,
      "date" : date ,
      "tel" : tel ,
      "email" : email ,
      "pass" : passCtrl.text,
    };
    var res = await http.post(Uri.parse(url),body: data);
    if(jsonDecode(res.body) == "true"){
      global.client_id = code;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          FormPage()), (Route<dynamic> route) => false);
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
    passCtrl =  TextEditingController();
    passConCtrl =  TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  containerShadow
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 35),
                    child: Text("un compte a été créé voici votre \ncode client: ${code}\n veuillez saisier un mot de passe pour finir la procédure",
                        style: lableStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20 ,),
                  TextField(
                      controller: passCtrl,
                      decoration: textInputDeco.copyWith(labelText: "Mot de passe",hintText: 'Mot de passe', prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[600],
                      ),)
                  ),
                  SizedBox(height: 20 ,),
                  TextField(
                      controller: passConCtrl,
                      decoration: textInputDeco.copyWith(labelText: "Confirmer Mot de passe",hintText: 'Confirmer Mot de passe' , prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[600],
                      ),)
                  ),

                  SizedBox(height: 50 ,),
                  ElevatedButton(
                    onPressed: processing == false ? (){
                      ajouterClient();
                    } : null,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                    ),
                    child:  Padding(
                      padding:  EdgeInsets.fromLTRB(30, 13, 30, 13),
                      child: processing == false ? Text(
                        "Confirmer",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ) : spinkit,
                    ),
                  ),
                  SizedBox(height: 30 ,),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
