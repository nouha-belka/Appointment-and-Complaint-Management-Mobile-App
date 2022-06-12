import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trying_database_php/real_app/branchement/image.dart';
import 'package:trying_database_php/real_app/branchement/page_metrage.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';
import '../library.dart' as global;


class FormulairPage extends StatefulWidget {
  const FormulairPage({Key? key}) : super(key: key);

  @override
  _FormulairPageState createState() => _FormulairPageState();
}

class _FormulairPageState extends State<FormulairPage> {
  File? imageFile;
  String? imageData;
  String? idImageData, idImageData1, idImageData2, idImageData3, idImageData4;
  String buttonText = "Envoyer";
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  bool? exist;
  @override
  choiceImage() async {
    var pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
      imageData = base64Encode(imageFile!.readAsBytesSync());
      return imageData;
    } else {
      return null;
    }
  }

  void sendImage(String image_name, image, String state, int num) async {
    if (state != "Formulaire validé" && state != "en cours de validation") {
      print(global.compteur_id);
      var url =
          "http://${global.localhost}/php_project/web-flutter/formulair_envoi.php";
      var data = {
        "code": global.compteur_id,
        "nom_image": image_name,
        "image": image,
        "etat": "en cours de validation",
      };
      var res = await http.post(Uri.parse(url), body: data);

      if (jsonDecode(res.body) == "true") {
        print("true");
        setState(() {
          images[num].etat = "en cours de validation";
        });
      } else {
        print("false");
      }
      // print(res.body);
    }
  }
  void validerEtat() async {
      var url =
          "http://${global.localhost}/php_project/web-flutter/validerForm.php";
      var data = {
        "code": global.compteur_id,
      };
      var res = await http.post(Uri.parse(url), body: data);
      print(jsonDecode(res.body));
      if (jsonDecode(res.body) == "true"){
        print("true");
        setState(() {
          buttonText = "Suivant";
        });
      }


  }

  List<ImageData> images = [
    ImageData(nom: 'copie de carte d’identité', etat: 'pas d’image inseré'),
    ImageData(
        nom: 'Formulair de demande de branchement rempli et signé',
        etat: 'pas d’image inseré'),
    ImageData(nom: 'copie acte de propriété', etat: 'pas d’image inseré'),
    ImageData(
        nom: 'demande autorisation de voirie', etat: 'pas d’image inseré'),
    ImageData(
        nom: 'copie légalisée du registre de commerce',
        etat: 'pas d’image inseré'),
  ];
  bool checkValidList() {
    bool allValid = true;
    images.forEach((image) {
      if (image.etat != "Formulaire validé") {
        allValid = false;
      }
    });
    return allValid;
  }

  void getList() async {
    var url = "http://${global.localhost}/php_project/web-flutter/formulairUser.php";
    var data = {
      "code": global.compteur_id,
    };
    var res = await http.post(Uri.parse(url), body: data);
    //var res = await http.get(Uri.parse(url));
    var response = jsonDecode(res.body);
    if (response == "false") {
      print("false");
      exist = false;
    } else {
      setState(() {
        images = [];
      });
      exist = true;
      for (var i = 0; i < response.length; i++) {
        var map = HashMap.from((response[i]));
        setState(() {
          images.add(
            ImageData(nom: map['name'], etat: map['state']),
          );
        });
      }
      if(checkValidList()){
        // print("here");
        validerEtat();
      }else{
        buttonText = "Envoyer";
      }
      // checkValidList() ? buttonText = "Suivant" : buttonText = "Envoyer";
      // print("true");
      // print(images[0].etat);

      // print(images[1].nom);
      // print(images[0].etat);
    }
  }

  Widget returnImageContainer(String imageName, String imageState, int num) {
    TextStyle lableStyle =
        TextStyle(color: greyColor, fontSize: 17, fontWeight: FontWeight.w600);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01,
          horizontal: MediaQuery.of(context).size.width * 0.04),
      child: Column(
        children: [
          Text(
            imageName,
            style: lableStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.012,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: greyish,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  imageState,
                  style: lableStyle,
                ),
              ),
              ElevatedButton(
                onPressed: (imageState != "en cours de validation" &&
                        imageState != "Formulaire validé")
                    ? () async {
                        var res = await choiceImage();
                        if (res != null) {
                          setState(() {
                            images[num].etat = "image inseré";
                            num == 0
                                ? idImageData = res
                                : num == 1
                                    ? idImageData1 = res
                                    : num == 2
                                        ? idImageData2 = res
                                        : num == 3
                                            ? idImageData3 = res
                                            : idImageData4 = res;
                          });
                        }
                      }
                    : null,
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size.fromWidth(100)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
                  backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                ),
                child: Icon(Icons.image),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      resizeToAvoidBottomInset : false,
      backgroundColor: greyish,
      drawer: Menu(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 25,
              vertical: MediaQuery.of(context).size.height * 0.02),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        _scaffoldState.currentState!.openDrawer();
                      },
                      child: Icon(
                        Icons.menu_rounded,
                        color: textColor,
                        size: 35,
                      ),
                    ),
                    Text(
                      "veuillez saisir \nles formulaire suivants",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 23,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.menu_rounded,
                      color: greyish,
                      size: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: ContainerDeco,
                  child: Column(
                    children: [
                      // returnImageContainer(images[0].nom,images[0].etat,image_text0,0),
                      // returnImageContainer(images[1].nom,images[1].etat,image_text1,1),
                      // returnImageContainer(images[2].nom,images[2].etat,image_text2,2),
                      // returnImageContainer(images[3].nom,images[3].etat,image_text3,3),
                      // returnImageContainer(images[4].nom,images[4].etat,image_text4,4),
                      returnImageContainer(images[0].nom, images[0].etat, 0),
                      returnImageContainer(images[1].nom, images[1].etat, 1),
                      returnImageContainer(images[2].nom, images[2].etat, 2),
                      returnImageContainer(images[3].nom, images[3].etat, 3),
                      returnImageContainer(images[4].nom, images[4].etat, 4),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (buttonText == "Envoyer") {
                      if ((idImageData != null ||
                              images[0].etat == "Formulaire validé" ||
                              images[0].etat == "en cours de validation") &&
                          (idImageData1 != null ||
                              images[1].etat == "Formulaire validé" ||
                              images[1].etat == "en cours de validation") &&
                          (idImageData2 != null ||
                              images[2].etat == "Formulaire validé" ||
                              images[2].etat == "en cours de validation") &&
                          (idImageData3 != null ||
                              images[3].etat == "Formulaire validé" ||
                              images[3].etat == "en cours de validation") &&
                          (idImageData4 != null ||
                              images[4].etat == "Formulaire validé" ||
                              images[4].etat == "en cours de validation")) {
                        sendImage(
                            images[0].nom, idImageData, images[0].etat, 0);
                        sendImage(
                            images[1].nom, idImageData1, images[1].etat, 1);
                        sendImage(
                            images[2].nom, idImageData2, images[2].etat, 2);
                        sendImage(
                            images[3].nom, idImageData3, images[3].etat, 3);
                        sendImage(
                            images[4].nom, idImageData4, images[4].etat, 4);

                      } else {
                        print("not all inserted");
                      }
                    } else {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MetragePage()),
                      );
                    }

                    // getList();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 10),
                    child: Text(
                      buttonText,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
