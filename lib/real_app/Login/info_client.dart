import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/Login/confirmer_inscription.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:http/http.dart' as http;
import '../library.dart' as global;

class infoClientForm extends StatefulWidget {
  const infoClientForm({Key? key}) : super(key: key);

  @override
  _infoClientFormState createState() => _infoClientFormState();
}

class _infoClientFormState extends State<infoClientForm> {
  late TextEditingController  nomCtrl, prenomCtrl,dateCtrl,telCtrl,emailCtrl;
  String? code;
  bool processing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomCtrl =  TextEditingController();
    prenomCtrl =  TextEditingController();
    dateCtrl =  TextEditingController();
    telCtrl =  TextEditingController();
    emailCtrl =  TextEditingController();
  }
  void generateId() async{
    setState(() {
      processing = true;
    });
    // while(true){
    //   code = random.nextInt(100000) + 10;
    //   print(code.toString());
    //   var url = "http://192.168.56.1/php_project/web-flutter/check_code.php";
    //   var data = {
    //     "code" : code.toString(),
    //   };
    //   var res = await http.post(Uri.parse(url),body: data);
    //   if(jsonDecode(res.body) == "false"){
    //     break;
    //   }
    // }
    var url = "http://${global.localhost}/php_project/web-flutter/check_code.php";
    var res = await http.get(Uri.parse(url));
    // print(jsonDecode(res.body));
    String response = jsonDecode(res.body);
    if(response != "false"){
      code = response.toString();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Confirmer(code: code!,nom: nomCtrl.text,prenom: prenomCtrl.text,date: dateCtrl.text,tel: telCtrl.text,email: emailCtrl.text)),
      );
    }


    setState(() {
      processing = false;
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 30),
              child: Column(
                children: [
                  SizedBox(height: 30 ,),
                  TextField(
                      controller: nomCtrl,
                      decoration: textInputDeco.copyWith(labelText: "Nom",hintText: 'Nom', prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.grey[600],
                      ),)
                  ),
                  SizedBox(height: 20 ,),
                  TextField(
                      controller: prenomCtrl,
                      decoration: textInputDeco.copyWith(labelText: "Prénom",hintText: 'Prénom' , prefixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.grey[600],
                      ),)
                  ),
                  SizedBox(height: 20 ,),
                  TextField(
                      controller: dateCtrl,
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
                  SizedBox(height: 20 ,),
                  TextField(
                      controller: telCtrl,
                      decoration: textInputDeco.copyWith(labelText: "Numéro de Téléphone",hintText: 'Numéro de Téléphone' , prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey[600],
                      ),)
                  ),
                  SizedBox(height: 20 ,),
                  TextField(
                      controller: emailCtrl,
                      decoration: textInputDeco.copyWith(labelText: "Email",hintText: 'Email' , prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey[600],
                      ),)
                  ),
                  SizedBox(height: 50 ,),
                  ElevatedButton(
                    onPressed: (){
                      generateId();
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
                        "Creér compte",
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
    );
  }
}
