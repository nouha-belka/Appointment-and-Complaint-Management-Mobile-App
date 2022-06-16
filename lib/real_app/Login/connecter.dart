import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trying_database_php/real_app/Login/info_client.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'package:trying_database_php/real_app/pages/form_page.dart';

import 'dart:convert';

import '../help/home_page2.dart';
import '../library.dart' as global;
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController  codectrl, passctrl;
  bool isObs = true;
  bool processing = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codectrl =  TextEditingController();
    passctrl =  TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        containerShadow
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                  padding: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 80 ,),
                        TextFormField(
                            controller: codectrl,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir votre code' :  null  ,
                            decoration: textInputDeco.copyWith(labelText: "Code client",hintText: 'Code client', prefixIcon: Icon(
                            Icons.account_circle,
                            color: Colors.grey[600],
                          ),)
                        ),
                        SizedBox(height: 40 ,),
                        TextFormField(
                            controller: passctrl,
                            obscureText: isObs,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir votre mot de pass' :  null  ,
                            decoration: textInputDeco.copyWith(labelText: "Mot de passe",hintText: 'Mot de passe' ,
                              prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                            ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isObs = !isObs;
                                  });
                                },
                                icon: Icon(
                                  isObs ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[900],
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 50 ,),
                        ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()){
                              signInUser();
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                            ),
                              backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                          ),
                          child:  Padding(
                            padding:  EdgeInsets.fromLTRB(30, 13, 30, 13),
                            child: processing == false ? Text(
                                "Se connecter",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ) : spinkit,
                          ),
                        ),
                        SizedBox(height: 30 ,),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                infoClientForm()), (Route<dynamic> route) => false);
                          },
                          child: const Text(
                              "Demande de compte",
                            style: TextStyle(color: Color.fromRGBO(69, 135, 150, 1),fontSize: 17,fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 50 ,),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 20, 30, 20),
                  child: Image.asset("assets/Logo.png"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void signInUser() async{
    setState(() {
      processing = true;
    });
    var url = "http://${global.localhost}/php_project/web-flutter/seConnecter.php";
    var data = {
      "code" : codectrl.text,
      "pass" : passctrl.text,
    };
    var res = await http.post(Uri.parse(url),body: data);
    if(jsonDecode(res.body) == "problème de connexion"){
      Fluttertoast.showToast(msg: "",toastLength: Toast.LENGTH_SHORT);
    }else{
      if(jsonDecode(res.body) != "false"){
        Fluttertoast.showToast(msg: "compte existe",toastLength: Toast.LENGTH_SHORT);
        var resCode = jsonDecode(res.body);
        var map1 = HashMap.from((resCode[0]));
        var map2 = resCode[1];
        global.Client cli = global.Client(nom: map1["nom"],prenom: map1["prenom"],date: map1["date"],email: map1["email"],tel: map1["tel"]);
        setState(() {
          global.client = cli;
          global.listComp = map2;
          global.client_id = codectrl.text;
        });
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            FormPage()), (Route<dynamic> route) => false);

      }else{
        Fluttertoast.showToast(msg: "le compte n'existe pas, veuillez vous inscrire",toastLength: Toast.LENGTH_SHORT);
      }
    }

    setState(() {
      processing = false;
    });
  }
}
