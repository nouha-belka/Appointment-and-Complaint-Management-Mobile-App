import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/rendezVous/rendez_vous.dart';

import 'fair_rendez_vous.dart';

class RdTile extends StatelessWidget {
  RendezVous rendezVous ;
  RdTile({required this.rendezVous});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){print("${this.rendezVous.sujet}");} ,
          child: Container(
              decoration: new BoxDecoration (
                borderRadius: BorderRadius.all(Radius.circular(13),),
                color: greyish,
              ),
              child : ListTile(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  FairRendezVous(rendezVous: this.rendezVous,)),
                  );
                },
                tileColor: greyish,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Le: ${this.rendezVous.date} ${this.rendezVous.heure}",
                        style: TextStyle(color: textColor, fontSize: 16,fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      "${this.rendezVous.sujet}",
                      style: TextStyle(color: textColor, fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${this.rendezVous.agent}",
                      style: TextStyle(color: textColor, fontSize: 18,fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              )
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}
