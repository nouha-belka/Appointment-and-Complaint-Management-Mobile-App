import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
const mainColor = Color.fromRGBO(69, 135, 150, 1);
var textColor = Color.fromRGBO(63, 61, 86, 1);
var greyish = Color.fromRGBO(248, 248, 248, 1);
var  textInputDeco = InputDecoration(
  // prefixIcon: Icon(
  //     Icons.calendar_today_sharp,
  //   color: Colors.grey[600],
  // ),
  hintStyle: TextStyle(
    color: Colors.grey[600],
    fontSize: 15,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color : Color.fromRGBO(170, 168, 168, 1.0),width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color : mainColor,width: 2),
    borderRadius: BorderRadius.circular(15),
  ),
  labelStyle: TextStyle(
    color: Color.fromRGBO(170, 168, 168, 1.0)
  ),
  floatingLabelStyle: TextStyle(
      color: mainColor,
    fontSize: 20
  ),
);

var textInputDecoTrans = InputDecoration(
  filled: true,
  fillColor: Color.fromRGBO(248, 248, 248, 1),
  hintText: "Date",

  hintStyle: TextStyle(
    color: Colors.grey[600],
    fontSize: 15,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color : Colors.transparent),
    borderRadius: BorderRadius.circular(10),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color : Colors.transparent),
    borderRadius: BorderRadius.circular(10),
  ),

);

const spinkit = SpinKitThreeBounce(
  color:  Colors.white,
  size: 30.0,
);
const greyColor = Color.fromRGBO(63, 61, 86, 1);
const menuTextStyle = TextStyle(fontSize: 17,color:greyColor );

const containerShadow = BoxShadow(
color: Colors.black,
offset: Offset(0.0, 3), //(x,y)
blurRadius: 6.0,
);

Future<String> datePick(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
      context: context, initialDate: DateTime.now(),
      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
      lastDate: DateTime(2101)
      builder: (context, child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: mainColor, // header background color
          onPrimary: Colors.white, // header text color
          onSurface: greyColor, // body text color
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: mainColor, // button text color
          ),
        ),
      ),
      child: child!,
    );
  },
  );
  if(pickedDate != null ){
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    return formattedDate;
  }else{
    return "";
  }
}

var ContainerDeco =  BoxDecoration(
color: Colors.white,
boxShadow: [
  BoxShadow(
    color: Color.fromRGBO(137, 137, 137, 0.6),
    offset: Offset(0, 2), //(x,y)
    blurRadius: 2,
  )
],
borderRadius: BorderRadius.all(Radius.circular(17),),
);

var inputTrans = InputDecoration(
  filled: true,
  fillColor: Color.fromRGBO(248, 248, 248, 1),

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color : Colors.transparent),
    borderRadius: BorderRadius.circular(15),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color : Colors.transparent),

  ),
);

var containerTrans = BoxDecoration(
    color:  greyish,
    borderRadius: BorderRadius.circular(7.0),
    border: Border.all(color: greyish)
);

Widget textLable(content){
  return Align(
    alignment : Alignment.topLeft ,
    child: Text(
      "  ${content}",
      style: TextStyle(color: Color.fromRGBO(63, 61, 86, 1), fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}