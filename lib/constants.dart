import 'package:flutter/material.dart';

const TextStyle tsSample = TextStyle(
  fontFamily: "MarkoOne",
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
const TextStyle tsBetOrange = TextStyle(
  fontFamily: "MarkoOne",
  fontSize: 45,
  //fontWeight: FontWeight.bold,
  color: clrMrOrange,
);
const TextStyle tsPink = TextStyle(
  fontFamily: "MarkoOne",
  fontSize: 50,
  //fontWeight: FontWeight.bold,
  color: clrMrPink,
);
const TextStyle tsWin = TextStyle(
  fontFamily: "MarkoOne",
  fontSize: 35,
  //fontWeight: FontWeight.bold,
  color: Colors.amber,
);
const TextStyle tsLose = TextStyle(
  fontFamily: "MarkoOne",//"Podkova",
  fontSize: 50,
  color: Colors.amber,
  fontWeight: FontWeight.bold,
);
const TextStyle tsDealer = TextStyle(
  fontFamily: "MarkoOne",
  fontSize: 50,
  color: Color(0xFF004D40),

);
const TextStyle tsLoseLine = TextStyle(
    fontFamily: "MarkoOne",
    fontSize: 50,
    color: clrMrPink,
    decoration: TextDecoration.lineThrough,
    decorationColor: Colors.white,
    decorationStyle: TextDecorationStyle.wavy
);

const double dfltRadius = 15;
const String imgChip100 = "assets/chip/chip100.png";
const String imgChip300 = "assets/chip/chip300.png";
const String imgChip500 = "assets/chip/chip500.png";
const String imgConf = "assets/chip/conf.png";

//"MrPink" , "MrWhite" , "MrOrange", "MrBrown", "MrBlue", "MrBlonde"
const Color clrMrPink = Color(0xFFFF2171);
const Color clrMrWhite = Color(0xFFFFF4F4);
const Color clrMrOrange = Color(0xFFF86F03);
const Color clrMrBrown = Color(0xFF3F2305);
const Color clrMrBlue = Color(0xFF5A96E3);
const Color clrMrBlonde = Color(0xFFfaf0be);

const List<Color> clrs = [
  clrMrPink,
  clrMrWhite,
  clrMrOrange,
  clrMrBrown,
  clrMrBlue,
  clrMrBlonde,
];

const RoundedRectangleBorder shapeUpBorderRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(dfltRadius),
      topRight: Radius.circular(dfltRadius)),
);
