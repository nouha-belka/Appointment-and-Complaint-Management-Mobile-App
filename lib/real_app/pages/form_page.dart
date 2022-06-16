import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/reclamation/reclamation_form.dart';
import 'package:trying_database_php/real_app/rendezVous/envoye_raison.dart';
import 'package:trying_database_php/real_app/widgets/form_container.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;
class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController dateinput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(
            "Form",
          style: TextStyle(color: Colors.white, fontFamily: 'MPLUS'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // TextField(
            //   controller: dateinput, //editing controller of this TextField
            //   decoration:textInputDecoTrans,
            //   readOnly: true,  //set it true, so that user will not able to edit text
            //   onTap: () async {
            //     setState(() async{
            //       dateinput.text = await datePick( context);
            //     });
            //
            //   },
            // ),
            FormContainer(
              phrase: "Pour faire des Réclamations \nclickez ici",
              buttonText: "Faire Réclamations",
              containerIcon : Icons.sd_card_alert_outlined,
              onTapForm: () => Get.to(() => ReclamationForm()),
            ),


            FormContainer(
              phrase: "Pour demander des Rendez-vous \nclickez ici",
              buttonText: "Faire Rendez-vous",
              containerIcon : Icons.calendar_today_sharp,
              onTapForm: () => Get.to(() => EnvoyeRaison()),),

          ],
        ),
      ),
    );
  }
}
