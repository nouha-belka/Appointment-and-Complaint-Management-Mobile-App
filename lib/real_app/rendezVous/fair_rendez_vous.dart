import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';


class FairRendezVous extends StatefulWidget {
   FairRendezVous({Key? key}) : super(key: key);

  @override
  State<FairRendezVous> createState() => _FairRendezVousState();
}

class _FairRendezVousState extends State<FairRendezVous> {
  TextEditingController dateinput = TextEditingController();
  TextStyle styleText = TextStyle( color: textColor, fontSize: 25, fontWeight: FontWeight.w600);
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];


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
          "Fair Rendez-vous",
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
              Text(
                "votre rendez vous est\n validé veillez choisir une\n date",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 20,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: ContainerDeco,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextLable(content: "Sujet"),
                      //SizedBox(height: 5,),
                      Container(
                        height: MediaQuery.of(context).size.height*0.06,
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                          decoration: inputTrans.copyWith(enabledBorder: border,focusedBorder: border),
                        ),
                      ),
                      SizedBox(height: 5,),
                      //SizedBox(height: 10,),
                      TextLable(content: "Description"),
                      TextField(
                        maxLines: 6,
                        style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                        decoration: inputTrans,
                      ),
                      SizedBox(height: 5,),
                      TextLable(content: "Date"),
                      //SizedBox(height: 17,),
                      Container(
                        height: MediaQuery.of(context).size.height*0.06,
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                          decoration: inputTrans.copyWith(enabledBorder: border,focusedBorder: border),
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextLable(content: "Heure"),
                      Container(
                        height: MediaQuery.of(context).size.height*0.06,
                        child: TextField(
                          style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1),fontSize: 17,fontWeight: FontWeight.w600),
                          decoration: inputTrans.copyWith(enabledBorder: border,focusedBorder: border),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        ElevatedButton(
                          onPressed: (){
                            //global.client_id = "hhhh";
                            //print(global.client_id);

                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                          ),
                          child:  Padding(
                            padding:  EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text(
                              "Confirmer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ) ,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            //global.client_id = "hhhh";
                            //print(global.client_id);

                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),)
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                          ),
                          child:  Padding(
                            padding:  EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Text(
                              "Changer date",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ) ,
                          ),
                        ),]
                      )

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

