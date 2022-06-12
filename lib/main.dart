import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trying_database_php/real_app/Login/info_client.dart';
import 'package:trying_database_php/real_app/Login/connecter.dart';

import 'package:trying_database_php/real_app/branchement/formulair_page.dart';
import 'package:trying_database_php/real_app/branchement/page_adresse.dart';
import 'package:trying_database_php/real_app/branchement/page_branchement.dart';
import 'package:trying_database_php/real_app/branchement/page_paiment.dart';
import 'package:trying_database_php/real_app/branchement/page_metrage.dart';

import 'package:trying_database_php/real_app/help/home_page.dart';
import 'package:trying_database_php/real_app/help/home_page2.dart';
import 'package:trying_database_php/real_app/compteur/page_compteur.dart';
import 'package:trying_database_php/real_app/pages/trying.dart';
import 'package:trying_database_php/real_app/reclamation/rec_list.dart';
import 'package:trying_database_php/real_app/rendezVous/en_attente.dart';
import 'package:trying_database_php/real_app/rendezVous/envoye_raison.dart';
import 'package:trying_database_php/real_app/rendezVous/fair_rendez_vous.dart';

import 'package:trying_database_php/real_app/widgets/date_picker.dart';
import 'package:trying_database_php/real_app/pages/form_page.dart';
import 'package:trying_database_php/real_app/reclamation/reclamation_form.dart';


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home:  Login(),
    )
  );
}
