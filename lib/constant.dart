import 'package:flutter/material.dart';

//Colors
const kSteelBlue = Color(0xFFA7BED3);
const kLightBlue = Color(0xFFC6E2E9);
const kCream = Color(0xFFF1FFC4);
const kApricot = Color(0xFFFFCAAF);
const kTan = Color(0xFFDAB894);
const kBackgroundColor = Colors.grey;

//Text Colors
const kTitleTextColor = Colors.black;
const kSubTitleTextColor = Colors.black54;
const kTextColor = Colors.black26;

///Text styles
const kHeadingTextStyle = TextStyle(
  fontSize: 22.0,
  color: kTitleTextColor,
  fontWeight: FontWeight.w800,
);

const kTitleTextstyle = TextStyle(
  fontSize: 20,
  color: kSubTitleTextColor,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(
  fontSize: 16.0,
  color: kSubTitleTextColor,
  fontWeight: FontWeight.w400,
);

const kButtonTextStyle =
    TextStyle(color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 16);

final kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.white),
  padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
  fixedSize: MaterialStateProperty.all(const Size.fromWidth(450)),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
    ),
  ),
);

const space = SizedBox(height: 20);

const smallSpace = SizedBox(height: 10);
