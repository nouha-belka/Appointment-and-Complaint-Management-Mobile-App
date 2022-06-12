import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/reclamation/reclamation.dart';

class RecTile extends StatelessWidget {
  Reclamation rec;
  RecTile({required this.rec});
  TextStyle _textStyle = TextStyle(color: textColor, fontSize: 15,fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){},
          child: Container(
            decoration: new BoxDecoration (
              borderRadius: BorderRadius.all(Radius.circular(13),),
              color: greyish,
            ),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              tileColor: greyish,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "reclamation numéro: ${this.rec.id}",
                      style: _textStyle,
                    ),
                  ),
                  Text(
                    "Le: ${this.rec.date}",
                    style: _textStyle,
                  ),
                  Text(
                    "Compteur: ${this.rec.numComp}",
                    style: _textStyle,
                  ),
                  Text(
                    "Etat: ${this.rec.etat}",
                    style: _textStyle,
                  ),

                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
