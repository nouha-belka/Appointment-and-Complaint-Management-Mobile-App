import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/branchement/formulair_page.dart';
import 'package:trying_database_php/real_app/branchement/page_branchement.dart';
import 'package:trying_database_php/real_app/branchement/page_metrage.dart';
import 'package:trying_database_php/real_app/branchement/page_paiment.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import '../library.dart' as global;
import 'compteur.dart';

class CompTile extends StatelessWidget {
  Compteur comp;
   CompTile({required this.comp});
  TextStyle _textStyle = TextStyle(color: textColor, fontSize: 17,fontWeight: FontWeight.w400);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            global.compteur_id = this.comp.id;
            if(this.comp.etat == 'en attente des formulaires' || this.comp.etat == 'formulaires en cours de validation'){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormulairPage()),
              );
            }else{
              if(this.comp.etat == 'date de métrage pas encore fixé' || this.comp.etat == 'en attente de métrage'){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MetragePage()),
                );
              }else{
                if(this.comp.etat == 'prix de branchement pas encore fixé' || this.comp.etat == 'prix fixé en attente de paiement'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaimentPage()),
                  );
                }else{
                  if(this.comp.etat == 'date de branchement pas encore fixé' || this.comp.etat == 'en attente de branchement' || this.comp.etat == 'branchement realisé'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BranchementPage()),
                    );
                  }
                }
              }
            }
          },
          child: Container(
            decoration: new BoxDecoration (
              borderRadius: BorderRadius.all(Radius.circular(13),),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              tileColor: greyish,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'compteur numéro: ', style: _textStyle.copyWith(fontWeight: FontWeight.bold),),
                        TextSpan(text: '${this.comp.id}', style: _textStyle,),
                      ],
                    ),
                  ),
                  SizedBox(height: 3,),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'situé a : ', style: _textStyle.copyWith(fontWeight: FontWeight.bold),),
                          TextSpan(text: '${this.comp.adresse}', style: _textStyle,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),

                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Etat : ', style: _textStyle.copyWith(fontWeight: FontWeight.bold,color: mainColor),),
                          TextSpan(text: '${this.comp.etat}', style: _textStyle,),
                        ],
                      ),
                    ),
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
