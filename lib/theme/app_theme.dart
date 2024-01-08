import 'package:news/util/hexcode.dart';
import 'package:flutter/material.dart';
// import 'package:tourease/util/hexcode.dart';

class AppTheme {
  AppTheme._();
  static const Color primaryColor = Color.fromARGB(255, 66, 47, 47);
  static const Color colorWhite54 = Colors.white54;

  static Color themeColor = HexColor('#4bb6ff');
  static const Color colorWhite30 = Colors.white30;
  static const Color colorWhite38 = Colors.white38;
  static const Color colorWhite60 = Colors.white60;

  // static const Color colorWhite = Colors.white;

  static const Color colorWhite = Colors.white;
  static const Color colorblack = Colors.black;
  static const Color colorblack12 = Colors.black12;
  static const Color colorblack87 = Colors.black87;

  static const Color colorblue = Colors.blue;
  static const Color colorRed = Colors.red;
  static const Color colorGreen = Colors.green;

  static const Color colorblack45 = Colors.black45;
  static const Color colorblack54 = Colors.black54;

  static const Color colorblack38 = Colors.black38;
  static Color tutorialAppbarColor = HexColor(
    '#6BB8FF',
  );

  static Color buttonThemeColor = HexColor('#46B4FF');
  static Color editProfileBodyColor = HexColor('#F5F5F5');

  static const Color colorPrimaryTheme = Color.fromARGB(163, 153, 218, 240);
  static TextTheme textTheme = const TextTheme();
  static const String appFontName = 'Roboto';
  static const Color greyColor = Colors.grey;
  static const FontWeight fontWeight = FontWeight.w300;
  static Color customFocusColor = HexColor('#4bb6ff');
  static Color profilleSubTitleThemeColor = HexColor('#8E89A9');
  static Color connectSubTitleThemeColor = HexColor('#8E89A9');

  static const Color textFieldIconColor = Colors.black38;
  static const Color textFieldHintColor = Colors.black38;
  static const Color colorTransprant = Colors.transparent;
  static Color customButtonBgColor = HexColor('#4bb6ff');
  static const Color filterBoxshadowColor = Color.fromRGBO(205, 214, 235, 0.2);
  static Color connectBodyColor = HexColor('#F5F5F5');
  static Color splashBodyColor = HexColor('#f2f0f6');
  static Color productTileColor = HexColor('#f6f7fb');

  //tutorial page

  static List<Color> tutorialBgColor = [
    HexColor('#6BB8FF'),
    HexColor('#84D3FF').withOpacity(0.8),
    HexColor('#84D3FF').withOpacity(0.6)
  ];
  static const Color dotColor = Colors.white54;

// Home page
  static Color homeBackgroundColor = HexColor("#f0f0f0");

  // detail page
  static Color detailMapBoxColor = HexColor('#E4E2EC');
  static Color detailMapBoxIconColor = HexColor('#8E89A9');

  static const Offset offset1 = Offset(10, 9);
  static const Offset offset2 = Offset(-8, -7);
  static const Offset offset3 = Offset(7, -3);
}
