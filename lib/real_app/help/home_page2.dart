import 'dart:convert';
import 'package:get/get.dart';
import 'package:trying_database_php/real_app/help/client_page.dart';
import 'package:trying_database_php/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  bool signin = true;
  late TextEditingController  codectrl, passctrl;
  bool processing = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codectrl =  TextEditingController();
    passctrl =  TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Image.asset('assets/SeaalLogo.png'),
            ),
            boxUi(),
          ],
        ),
      ),
    );
  }
  void signInUser() async{
    setState(() {
      processing = true;
    });
    var url = "http://192.168.56.1/php_project/web-flutter/seConnecter.php";
    var data = {
      "code" : codectrl.text,
      "pass" : passctrl.text,
    };
    var res = await http.post(Uri.parse(url),body: data);
    if(jsonDecode(res.body) == "true"){
      Fluttertoast.showToast(msg: "account exists",toastLength: Toast.LENGTH_SHORT);

    }else{
      Fluttertoast.showToast(msg: "account doesn't exist, Please sign up ",toastLength: Toast.LENGTH_SHORT);
    }
    setState(() {
      processing = false;
    });
  }
  Widget boxUi() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        signin = true;
                      });
                    },
                    child: Text(
                      'Se Connecter',
                      style: GoogleFonts.varelaRound(
                          color: signin == true ? Color.fromRGBO(
                              110, 203, 245, 0.9019607843137255) : Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    )),

              ],
            ),
            signInUi(),

          ],
        ),
      ),
    );
  }
  Widget signInUi(){
    return Column(
      children: [
        TextField(
          controller: codectrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Code Client',
          ),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Mot De Pass',
          ),
        ),
        SizedBox(height: 10 ,),
        MaterialButton(
            onPressed: (){

              Get.to(ClientPage());
            },
            child: processing == false ? Text(
              'Connecter',
              style: GoogleFonts.varelaRound(
                fontSize: 18,
                color: Color.fromRGBO(
                    110, 203, 245, 0.9019607843137255),
              ),
            ) : spinkit
        ),
      ],
    );
  }
}
