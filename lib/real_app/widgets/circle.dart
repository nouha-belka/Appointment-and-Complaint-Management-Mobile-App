import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';

class Circle extends StatelessWidget {
  IconData circleIcon;
  bool isFiniished ;
  Circle({required this.circleIcon,required this.isFiniished });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: new BoxDecoration(
        color: isFiniished ? mainColor : Colors.black26,
        shape: BoxShape.circle,
      ),
      child: Icon(
        this.circleIcon,
        color: Colors.white,
        size: 70,
      ),
    );
  }
}
