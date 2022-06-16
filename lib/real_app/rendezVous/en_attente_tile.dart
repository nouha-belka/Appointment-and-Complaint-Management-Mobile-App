import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/rendezVous/page_refus.dart';
import 'package:trying_database_php/real_app/rendezVous/raison.dart';
import 'package:trying_database_php/real_app/rendezVous/view.dart';

class RaisonTile extends StatelessWidget {
  Raison raison ;
  bool page ;
  RaisonTile({required this.raison, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            page ? Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  View(rai: this.raison,)),
            ) : Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  PageRefus(rai: this.raison,)),
            );
          } ,
          child: Container(
              decoration: new BoxDecoration (
                  borderRadius: BorderRadius.all(Radius.circular(13),),
                  color: greyish,
              ),
              child : ListTile(
                tileColor: greyish,
                title: Text(
                    "${this.raison.sujet}",
                  style: TextStyle(color: textColor, fontSize: 18,fontWeight: FontWeight.w600),
                ),
                leading: CircleAvatar(
                  // backgroundColor: this.raison.etat == "attente"? Color.fromRGBO(173, 173, 173, 1) :mainColor,
                  backgroundColor: mainColor,
                  radius: 10,),
              )
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}

