import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';



class DatePicker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<DatePicker>{
  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title:Text("DatePicker on TextField"),
          backgroundColor: Colors.redAccent, //background color of app bar
        ),
        body:Container(
            padding: EdgeInsets.all(15),
            height:150,
            child:Center(
                child:TextField(
                  controller: dateinput, //editing controller of this TextField
                  decoration:textInputDecoTrans,
                  readOnly: true,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    setState(() async{
                      dateinput.text = await datePick( context);
                    });

                  },
                )
            )
        )
    );
  }
}