import 'dart:convert';
import 'package:trying_database_php/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool signin = true;
  late TextEditingController namectrl, emailctrl, passctrl;
  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namectrl =  TextEditingController();
    emailctrl =  TextEditingController();
    passctrl =  TextEditingController();
  }
  @override

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children:   [
         Icon(Icons.account_circle, size: 200,),
          boxUi(),
        ],
      ),
    );
  }
void registerUser() async{
    setState(() {
      processing = true;
    });
    var url = "http://192.168.56.1/php_project/web-flutter/signup.php";
    var data = {
      "email" : emailctrl.text,
      "name" : namectrl.text,
      "pass" : passctrl.text,
    };
    var res = await http.post(Uri.parse(url),body: data);
    if(jsonDecode(res.body) == "account exists"){
      Fluttertoast.showToast(msg: "account exists, Please login",toastLength: Toast.LENGTH_SHORT);
    }else{
      if(jsonDecode(res.body) == "true"){
        Fluttertoast.showToast(msg: "account created",toastLength: Toast.LENGTH_SHORT);
      }else{
        Fluttertoast.showToast(msg: "Error",toastLength: Toast.LENGTH_SHORT);
      }
    }
    setState(() {
      processing = false;
    });
}

  void signInUser() async{
    setState(() {
      processing = true;
    });
    var url = "http://192.168.56.1/php_project/web-flutter/signin.php";
    var data = {
      "email" : emailctrl.text,
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


  //creating a widget called boxUi
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
                      'SIGN IN',
                      style: GoogleFonts.varelaRound(
                        color: signin == true ? Colors.blue : Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        signin = false;
                      });
                    } ,
                    child: Text(
                      'SIGN UP',
                      style: GoogleFonts.varelaRound(
                          color: signin != true ? Colors.blue : Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),
                    ))
              ],
            ),
            signin == true ? signInUi() : signUpUi(),

          ],
        ),
      ),
    );
  }

  Widget signInUi(){
    return Column(
      children: [
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Email',
          ),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Password',
          ),
        ),
        SizedBox(height: 10 ,),
        MaterialButton(
          onPressed: () => signInUser(),
          child: processing == false ? Text(
            'Sign In',
            style: GoogleFonts.varelaRound(
              fontSize: 18,
              color: Colors.blue,
            ),
          ) : spinkit
        ),
      ],
    );
  }

  Widget signUpUi(){
    return Column(
      children: [
        TextField(
          controller: namectrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Name',
          ),
        ),
        TextField(
          controller: emailctrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Email',
          ),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
            prefixIcon:  Icon(Icons.account_box),
            hintText: 'Password',
          ),
        ),
        SizedBox(height: 10 ,),
        MaterialButton(
          onPressed: () => registerUser(),
          child: processing == false ? Text(
            'Sign Up',
            style: GoogleFonts.varelaRound(
              fontSize: 18,
              color: Colors.blue,
            ) ,
          ) : spinkit
        ),
      ],
    );
  }
}
