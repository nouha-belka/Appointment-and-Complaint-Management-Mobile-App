import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:trying_database_php/real_app/help/constants.dart';

class CostumeTile extends StatefulWidget {
  String content;
  Function onTapFunstion;
  bool isChoosen ;
  int number;
  CostumeTile({required this.number,required this.content, required this.onTapFunstion,required this.isChoosen});

  @override
  State<CostumeTile> createState() => _CostumeTileState(number: this.number,content : this.content,onTapFunstion : this.onTapFunstion,isChoosen: this.isChoosen);
}

class _CostumeTileState extends State<CostumeTile> {
  String content;
  Function onTapFunstion;
  bool isChoosen;
  int number;
  _CostumeTileState({required this.number,required this.content, required this.onTapFunstion,required this.isChoosen});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: this.isChoosen ? mainColor : Colors.transparent,
      borderType: BorderType.RRect,
      dashPattern: [6,3],
      radius: Radius.circular(13),
      child: Container(
        decoration: new BoxDecoration (
            borderRadius: BorderRadius.all(Radius.circular(13),),
            color: Color.fromRGBO(248, 248, 248, 1)
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${this.widget.content}',
                style: menuTextStyle,
              ),
              onTap: () {
                this.onTapFunstion(this.content,this.number);
              },
            ),
          ],
        ),
      ),
    );
  }
}
