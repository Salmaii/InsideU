import 'package:flutter/material.dart';
import './size_configs.dart';

Color kPrimaryColor = const Color(0xffFC9803);
Color kSecondaryColor = const Color(0xffFFFFFF);
Color kTertiaryColor = Colors.black;

final kTitle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: SizeConfig.blockSizeH! * 7, //7
  color: kSecondaryColor,
);

final kTitleBlack = TextStyle(
  height: 0,
  fontWeight: FontWeight.w700,
  fontSize: SizeConfig.blockSizeH! * 9, //7
  color: kTertiaryColor,
  //fontFamily: 'Klasik',
);

final kBodyText1 = TextStyle(
  color: kSecondaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.5, //4.5
  fontFamily: 'Klasik',
);
