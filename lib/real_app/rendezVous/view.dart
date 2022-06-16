import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/rendezVous/raison.dart';
import 'package:trying_database_php/real_app/rendezVous/rendez_vous.dart';


class View extends StatefulWidget {
  Raison rai ;
  View({required this.rai});

  @override
  State<View> createState() => _ViewState(rai: this.rai);
}

class _ViewState extends State<View> {
  Raison rai ;
  _ViewState({required this.rai});
  TextEditingController dateinput = TextEditingController();
  TextStyle styleText = TextStyle( color: textColor, fontSize: 25, fontWeight: FontWeight.w600);

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyish,
      appBar: AppBar(
        title: Text(
          "Info demande",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(height: 10,),
              Container(
                decoration: ContainerDeco,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextLable(content: "Sujet"),
                      SizedBox(height: 5,),
                      TextFormField(
                        enabled: false,
                        initialValue: this.rai.sujet,
                        style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                        decoration: inputTrans.copyWith(enabledBorder: border,focusedBorder: border),
                      ),
                      SizedBox(height: 30,),
                      TextLable(content: "Description"),
                      SizedBox(height: 5,),
                      TextFormField(
                        enabled: false,
                        initialValue: this.rai.description,
                        maxLines: 6,
                        style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                        decoration: inputTrans,
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(color : Colors.transparent),
    borderRadius: BorderRadius.circular(10),
  );
}

class TextLable extends StatelessWidget {
  String content;
  TextLable({required this.content});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment : Alignment.topLeft ,
      child: Text(
        "  ${this.content}",
        style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

