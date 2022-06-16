import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/Login/connecter.dart';
import 'package:trying_database_php/real_app/Login/info_client.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/compteur/page_compteur.dart';
import 'package:trying_database_php/real_app/pages/form_page.dart';
import 'package:trying_database_php/real_app/pages/info_mod.dart';
import 'package:trying_database_php/real_app/reclamation/rec_list.dart';
import 'package:trying_database_php/real_app/rendezVous/en_attente.dart';
import '../library.dart' as global;
class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              global.client_id,
              style: TextStyle(fontSize: 17),
            ),
            accountEmail: Text(
                '${global.client.nom} ${global.client.prenom}',
              style: TextStyle(fontSize: 15),
            ),
            decoration: BoxDecoration(

              color: Colors.white,
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                  scale: 1.5,
                  image:AssetImage("assets/Vector (1).png"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.menu,
              color: greyColor,
            ),
            title: Text(
              'Accueil',
              style: menuTextStyle,
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  FormPage()), (Route<dynamic> route) => false);
            },
          ),
          Divider(
            color: mainColor,
            thickness: 2,
            height: 20,
            indent: 40,
            endIndent: 20,
          ),
          ListTile(
            leading: Icon(
                Icons.folder,
              color: greyColor,
            ),
            title: Text(
                'Mes réclamations',
              style: menuTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  ReclList()), (Route<dynamic> route) => false);

            },
          ),
          ListTile(
            leading: Icon(
              Icons.date_range,
              color: greyColor,
            ),
            title: Text(
              'Gestion rendez-vous',
              style: menuTextStyle,
            ),
            onTap: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  EnAttente()), (Route<dynamic> route) => false);

            },
          ),

          ListTile(
            leading: Icon(
              Icons.account_balance_wallet,
              color: greyColor,
            ),
            title: Text(
              'Compteur',
              style: menuTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  PageCompteur()), (Route<dynamic> route) => false);
            },
          ),
          Divider(
            color: mainColor,
            thickness: 2,
            height: 20,
            indent: 40,
            endIndent: 20,
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: greyColor,
            ),
            title: Text(
              'Mes informations',
              style: menuTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  infoClient()), (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: greyColor,
            ),
            title: Text(
              'Se deconnecter',
              style: menuTextStyle,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  Login()), (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
