import 'package:flutter/material.dart';


const double sidePadding = 20;
const double fontSizeH2 = 30;

const black = Color(0xFF1B202A);
const easyPurple = Color(0xFF6C5DD3);
const easySubText = Color(0xFF808191);
const formGrey = Color.fromRGBO(0, 0, 0, 0.1);


// Content Text Style
const TextStyle titleH1TextStyle = TextStyle(
  fontSize: fontSizeH2,
  color: black,
  height: 1.2,
  fontWeight: FontWeight.w700,
);

const TextStyle contentStyle = TextStyle(
  fontSize: 16,
  color: easySubText,
  height: 1.5,
  fontWeight: FontWeight.w400,
);

const TextStyle buttonStyleBold = TextStyle(
  fontSize: 16,
  color: Colors.white,
  height: 1.5,
  fontWeight: FontWeight.w700,
);

// Input Decoration
const InputDecoration loginInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  filled: true,
  fillColor: formGrey,
);