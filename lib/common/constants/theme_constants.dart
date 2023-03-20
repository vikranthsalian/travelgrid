import 'package:flutter/material.dart';

const Color customGold100 = Color(0xFF2854A1);
const Color customGold200 = Color(0xFFF0DB19);
const Color textColor100 = Color(0xFF000000);
const Color textColor50 = Color(0xFF3D3D3D);
const Color textColor10 = Color(0xFF737171);
const Color textColor3D = Color(0xFF3D3D3D);
const Color greyColorCC = Color(0xFFAEAEAE);
const Color greyColorC3 = Color(0xFFC3C3C3);
const Color greyColor8A = Color(0x668A8A8A);
const Color colorRed = Color(0xFFE90C0C);
const Color colorGreen = Color(0xFF00BD35);

const Color customErrorRed = Color(0xFFC5032B);

const Color customSurfaceWhite = Color(0xFFFFFBFA);
const Color customBackgroundWhite = Colors.white;

class GlobalTheme {
  final globalTheme = ThemeData(
    colorScheme: _customColorScheme,
    textTheme:  TextTheme(
      bodyText1: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w300,
        color: textColor50,
      ),
      bodyText2: TextStyle(
        color: textColor100,
        fontSize: 12,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w300,
      ),
      caption: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        color: textColor100,
      ),
      headline1: TextStyle(
        color: textColor100,
        fontSize: 32,
        fontFamily: 'Allison',
        fontWeight: FontWeight.bold,
      ),
      button: TextStyle(
        color: textColor100,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      headline2: TextStyle(
        color: textColor100,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: customGold100,
      // This will control the "back" icon
      iconTheme: IconThemeData(color: Colors.red),
      // This will control action icon buttons that locates on the right
      actionsIconTheme: IconThemeData(color: textColor100),
      centerTitle: false,
      elevation: 15,
      titleTextStyle: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontFamily: 'Allison',
        fontSize: 40,
      ),
    ),
  );
}

const ColorScheme _customColorScheme = ColorScheme(
  primary: customGold100,
  secondary: customGold200,
  primaryVariant: Colors.black,
  secondaryVariant: Colors.black,
  surface: Colors.purpleAccent,
  background: customSurfaceWhite,
  error: Colors.black,
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onSurface: textColor100,
  onBackground: customGold100,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);