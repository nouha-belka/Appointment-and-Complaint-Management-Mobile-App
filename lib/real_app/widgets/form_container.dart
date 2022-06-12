import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';

class FormContainer extends StatelessWidget {
  Function onTapForm;
  String phrase,buttonText;
  IconData containerIcon ;
  FormContainer({required this.phrase, required this.buttonText,required this.containerIcon, required this.onTapForm});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(170, 168, 168, 1.0),
              offset: Offset(0, 2), //(x,y)
              blurRadius: 2,
            ),
          ]
      ),
      height: 210,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${this.phrase}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: greyColor,
              fontSize: 20,
              fontWeight: FontWeight.w400
            ),
          ),
          TextButton.icon(
            // ignore: unnecessary_statements
            onPressed: () {onTapForm();},
            label: Text(
              '${this.buttonText}',
              style: TextStyle(fontSize: 25,color : mainColor , fontWeight: FontWeight.w400),
            ),
            icon: Icon(containerIcon , color: mainColor,size: 35,),
          )
        ],
      ),
    );
  }
}
