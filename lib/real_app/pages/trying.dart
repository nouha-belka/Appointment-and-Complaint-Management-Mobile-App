import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/pages/tile2.dart';
import 'package:trying_database_php/real_app/widgets/costume_tile.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';

class Trying extends StatefulWidget {
  const Trying({Key? key}) : super(key: key);

  @override
  _TryingState createState() => _TryingState();
}

class _TryingState extends State<Trying> {
  // List<String> contents = ["- Surfacturation",
  //   "- j'ai pas reçu une facture",
  //   "- je n'est pas ete relevé ",
  //   "- une fuite au niveaux extérieur",
  //   "- une fuite au niveaux intérieur",
  //   "- je suis victime de fraude",
  //   "- j'ai payé ma facture mais vous m'avez coupé la ligne",
  // ];
    Color color0 = Colors.transparent,color1 = Colors.transparent, color2 = Colors.transparent;
    Color color3 = Colors.transparent, color4 = Colors.transparent,color5 = Colors.transparent;
    Color color6 = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    List<Tile2> tiles2 = [
      Tile2(number: 0, content: "- Surfacturation ", isChoosen: false,onTapFunstion: (){},),
      Tile2(number: 1, content: "- j'ai pas reçu une facture", isChoosen: false,onTapFunstion: (){},),
      Tile2(number: 2, content: "- je n'est pas ete relevé ", isChoosen: false,onTapFunstion: (){},),
      Tile2(number: 3, content: "- une fuite au niveaux extérieur", isChoosen: false,onTapFunstion: (){},),
      Tile2(number: 4, content: "- une fuite au niveaux intérieur", isChoosen: false,onTapFunstion: (){},),
      Tile2(number: 5, content: "- je suis victime de fraude", isChoosen: false,onTapFunstion: (){},),
      Tile2(number: 6, content: "- j'ai payé ma facture mais vous m'avez coupé la ligne", isChoosen: false,onTapFunstion: (){},),
    ];
  void updateColor(int number){
    print(number);
    setState(() {
      color0  = color1 =  color2 = Colors.transparent;
      color3 = color4 = color5 = Colors.transparent;
      color6 = Colors.transparent;
      switch(number){
        case 0:{color0 = mainColor;}break;
        case 1:{color1 = mainColor;}break;
        case 2:{color2 = mainColor;}break;
        case 3:{color3 = mainColor;}break;
        case 4:{color4 = mainColor;}break;
        case 5:{color5 = mainColor;}break;
        case 6:{color6 = mainColor;}break;
      }
    });
  }
  setState(() {

  tiles2[0].onTapFunstion = updateColor;
  tiles2[1].onTapFunstion = updateColor;
  tiles2[2].onTapFunstion = updateColor;
  tiles2[3].onTapFunstion = updateColor;
  tiles2[4].onTapFunstion = updateColor;
  tiles2[5].onTapFunstion = updateColor;
  tiles2[6].onTapFunstion = updateColor;
  });
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Awesome Quotes'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children:
          [
            DottedBorder(
              color: color0,
              borderType: BorderType.RRect,
              dashPattern: [6,3],
              radius: Radius.circular(13),
              child : tiles2[0]
          ),
            DottedBorder(
                color: color1,
                borderType: BorderType.RRect,
                dashPattern: [6,3],
                radius: Radius.circular(13),
                child : tiles2[1]
            ),
            DottedBorder(
                color: color2,
                borderType: BorderType.RRect,
                dashPattern: [6,3],
                radius: Radius.circular(13),
                child : tiles2[2]
            ),
            DottedBorder(
                color: color3,
                borderType: BorderType.RRect,
                dashPattern: [6,3],
                radius: Radius.circular(13),
                child : tiles2[3]
            ),
            DottedBorder(
                color: color4,
                borderType: BorderType.RRect,
                dashPattern: [6,3],
                radius: Radius.circular(13),
                child : tiles2[4]
            ),
            DottedBorder(
                color: color5,
                borderType: BorderType.RRect,
                dashPattern: [6,3],
                radius: Radius.circular(13),
                child : tiles2[5]
            ),
            DottedBorder(
                color: color6,
                borderType: BorderType.RRect,
                dashPattern: [6,3],
                radius: Radius.circular(13),
                child : tiles2[6]
            )
          ]

      ),
    ) ;
  }
}
