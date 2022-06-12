import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';
import 'package:trying_database_php/real_app/widgets/circle.dart';
import 'package:trying_database_php/real_app/widgets/costume_tile.dart';
import 'package:trying_database_php/real_app/widgets/menu.dart';

class ProgressBar extends StatelessWidget {

  bool round1;
  bool round2;
  bool round3;
  bool round4;
  bool round5;
  String text;
  Function getMenu;
  ProgressBar({required this.text,required this.getMenu,this.round1 = false, this.round2 = false, this.round3 = false, this.round4 = false, this.round5 = false});
  double width = 25;
  double widthRect = 25;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  getMenu();
                },
                child: Icon(
                  Icons.menu_rounded,
                  color: textColor,
                  size: 35,
                ),
              ),
              Text(
                "Progrés",
                style: TextStyle(fontSize: 30,color: greyColor),
              ),
              Icon(
                  Icons.menu_rounded,
                color: Colors.white,
                size: 35,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: round1 ? mainColor : Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
            Container(height: 5,color: round2 ? mainColor : Colors.black26,width: widthRect,),
            Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: round2 ? mainColor : Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
            Container(height: 5,color: round3 ? mainColor : Colors.black26,width: widthRect,),
            Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: round3 ? mainColor : Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
            Container(height: 5,color: round4 ? mainColor : Colors.black26,width: widthRect,),
            Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: round4 ? mainColor : Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
            Container(height: 5,color: round5 ? mainColor : Colors.black26,width: widthRect,),
            Container(
              width: width,
              height: width,
              decoration: new BoxDecoration(
                color: round5 ? mainColor : Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        Text(
          text,
          style: TextStyle(fontSize: 20,color: mainColor,fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
