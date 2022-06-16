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

  final _formKey = GlobalKey<FormState>();
  TextStyle lableStyle = TextStyle(color: greyColor, fontSize: 22, );
  bool isObs1 = true;
  bool isObs2 = true;
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
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Form(
              key: _formKey,
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
                        TextFormField(
                            controller: passCtrl,
                            obscureText: isObs1,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir le mot de passe' : RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}").hasMatch(val) ? null : 'le mot de passe doit contenir au moins un majuscule  et un numéro' ,
                            decoration: textInputDeco.copyWith(labelText: "Mot de passe",hintText: 'Mot de passe',
                              prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                            ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isObs1 = !isObs1;
                                  });
                                },
                                icon: Icon(
                                  isObs1 ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[900],
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20 ,),
                        TextFormField(
                            controller: passConCtrl,
                            obscureText: isObs2,
                            validator: (val) => val != passCtrl.text ? 'Veuillez saisir le mot de passe' :  null  ,
                            decoration: textInputDeco.copyWith(labelText: "Confirmer Mot de passe",hintText: 'Confirmer Mot de passe' ,
                              prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey[600],
                            ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    isObs2 = !isObs2;
                                  });
                                },
                                icon: Icon(
                                  isObs2 ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey[900],
                                ),
                              ),
                            )
                        ),

                        SizedBox(height: 50 ,),
                        ElevatedButton(
                          onPressed: processing == false ? (){
                            if (_formKey.currentState!.validate()){
                              ajouterClient();
                            }
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
          ),
        ),
      ),
    );
  }
}
