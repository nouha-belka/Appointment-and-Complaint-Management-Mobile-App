import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';

class Tile2 extends StatefulWidget {
  String content;
  bool isChoosen ;
  int number;
  Function onTapFunstion;
  Tile2({required this.number,required this.content,required this.isChoosen,required this.onTapFunstion});
  @override
  _Tile2State createState() => _Tile2State(number: this.number,content: this.content,isChoosen: this.isChoosen,onTapFunstion: this.onTapFunstion );
}

class _Tile2State extends State<Tile2> {
  String content;
  bool isChoosen ;
  int number;
  Function onTapFunstion;
  _Tile2State({required this.number,required this.content,required this.isChoosen,required this.onTapFunstion});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(
          '${this.widget.content}',
          style: menuTextStyle,
        ),
        onTap: () {
          this.onTapFunstion(this.number);
        },
      ),
    );
  }
}
