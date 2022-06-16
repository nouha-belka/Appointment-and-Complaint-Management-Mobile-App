import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/Login/confirmer_inscription.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;

class infoClient extends StatefulWidget {
  const infoClient({Key? key}) : super(key: key);

  @override
  _infoClientState createState() => _infoClientState();
}

class _infoClientState extends State<infoClient> {
  late TextEditingController  nomCtrl, prenomCtrl,dateCtrl,telCtrl,emailCtrl;
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  String? code;
  bool processing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomCtrl =  TextEditingController(text: global.client.nom);
    prenomCtrl =  TextEditingController(text: global.client.prenom);
    dateCtrl =  TextEditingController(text: global.client.date);
    telCtrl =  TextEditingController(text: global.client.tel);
    emailCtrl =  TextEditingController(text: global.client.email);
  }
  void modify() async{
    setState(() {
      processing = true;
    });
    var url = "http://${global.localhost}/php_project/web-flutter/modifiClient.php";
    var data = {
      "code" : global.client_id ,
      "nom" : nomCtrl.text ,
      "prenom" : prenomCtrl.text ,
      "date" : dateCtrl.text ,
      "tel" : telCtrl.text ,
      "email" : emailCtrl.text ,
    };
    var res = await http.post(Uri.parse(url),body: data);
    // print(jsonDecode(res.body));
    String response = jsonDecode(res.body);
    if(response != "false"){
      Fluttertoast.showToast(msg: "informations modifiées",toastLength: Toast.LENGTH_SHORT);
      setState(() {
        global.client.nom = nomCtrl.text;
        global.client.prenom = prenomCtrl.text;
        global.client.date = dateCtrl.text;
        global.client.tel = telCtrl.text;
        global.client.email = emailCtrl.text;
      });
    }
    setState(() {
      processing = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      drawer: Menu(),
      // resizeToAvoidBottomInset : false,
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.05, 0, 0, MediaQuery.of(context).size.height*0.06),
                      child: InkWell(
                        onTap: (){
                          _scaffoldState.currentState!.openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
                    child: Column(
                      children: [
                        SizedBox(height: 30 ,),
                        TextFormField(
                            controller: nomCtrl,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir le nom' : RegExp(r"^[a-zA-Z ,.'-]{2,}").hasMatch(val) ? null : 'Nom invalide' ,
                            decoration: textInputDeco.copyWith(labelText: "Nom",hintText: 'Nom', prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.grey[600],
                            ),)
                        ),
                        SizedBox(height: 15 ,),
                        TextFormField(
                            controller: prenomCtrl,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir le prénom' : RegExp(r"^[a-zA-Z ,.'-]{2,}").hasMatch(val) ? null : 'Prénom invalide' ,
                            decoration: textInputDeco.copyWith(labelText: "Prénom",hintText: 'Prénom' , prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.grey[600],
                            ),)
                        ),
                        SizedBox(height: 15 ,),
                        TextFormField(
                          controller: dateCtrl,
                          validator: (val) => val!.isEmpty ? 'Veuillez saisir la date' :  null  ,
                          decoration: textInputDeco.copyWith(labelText: "Date de naissance",hintText: 'Date de naissance' , prefixIcon: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.grey[600],
                          ),),
                          readOnly: true,  //set it true, so that user will not able to edit text
                          onTap: () async {
                            var  date = await datePick( context);
                            setState(() {
                              dateCtrl.text = date;
                            });

                          },
                        ),
                        SizedBox(height: 15 ,),
                        TextFormField(
                            controller: telCtrl,
                            keyboardType: TextInputType. number,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir le numéro de téléphone' : RegExp(r"^(0)(2|5|6|7)[0-9]{8}").hasMatch(val) ? null : 'Numéro invalide' ,
                            decoration: textInputDeco.copyWith(labelText: "Numéro de Téléphone",hintText: 'Numéro de Téléphone' , prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.grey[600],
                            ),)
                        ),
                        SizedBox(height: 15 ,),
                        TextFormField(
                            controller: emailCtrl,
                            validator: (val) => val!.isEmpty ? 'Veuillez saisir l\'email' : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : 'Email invalide' ,
                            decoration: textInputDeco.copyWith(labelText: "Email",hintText: 'Email' , prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                            ),)
                        ),
                        SizedBox(height: 50 ,),
                        ElevatedButton(
                          onPressed: (){
                            if (_formKey.currentState!.validate()){
                              modify();
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
                              "Modifier",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ) : spinkit,
                          ),
                        ),
                        SizedBox(height: 20 ,),

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
