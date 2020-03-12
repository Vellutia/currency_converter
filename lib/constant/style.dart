import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff2196f3);
const Color accentColor = Color(0xfffafafa);

const TextTheme primaryTextTheme = TextTheme(
  bodyText1: TextStyle(
    color: accentColor,
  ),
  bodyText2: TextStyle(
    color: accentColor,
  ),
  button: TextStyle(
    color: accentColor,
  ),
  caption: TextStyle(
    color: accentColor,
  ),
  headline1: TextStyle(
    color: accentColor,
  ),
  headline2: TextStyle(
    color: accentColor,
  ),
  headline3: TextStyle(
    color: accentColor,
  ),
  headline4: TextStyle(
    color: accentColor,
  ),
  headline5: TextStyle(
    color: accentColor,
  ),
  headline6: TextStyle(
    color: accentColor,
  ),
  subtitle1: TextStyle(
    color: accentColor,
  ),
  subtitle2: TextStyle(
    color: accentColor,
  ),
);

const TextTheme accentTextTheme = TextTheme(
  bodyText1: TextStyle(
    color: primaryColor,
  ),
  bodyText2: TextStyle(
    color: primaryColor,
  ),
  button: TextStyle(
    color: primaryColor,
  ),
  caption: TextStyle(
    color: primaryColor,
  ),
  headline1: TextStyle(
    color: primaryColor,
  ),
  headline2: TextStyle(
    color: primaryColor,
  ),
  headline3: TextStyle(
    color: primaryColor,
  ),
  headline4: TextStyle(
    color: primaryColor,
  ),
  headline5: TextStyle(
    color: primaryColor,
  ),
  headline6: TextStyle(
    color: primaryColor,
  ),
  subtitle1: TextStyle(
    color: primaryColor,
  ),
  subtitle2: TextStyle(
    color: primaryColor,
  ),
);

const AppBarTheme primaryAppBarTheme = AppBarTheme(
  color: primaryColor,
  actionsIconTheme: primaryIconTheme,
  iconTheme: primaryIconTheme,
  textTheme: accentTextTheme,
);

const IconThemeData primaryIconTheme = IconThemeData(
  color: accentColor,
);

const IconThemeData accentIconTheme = IconThemeData(
  color: primaryColor,
);

const FloatingActionButtonThemeData floatingTheme =
    FloatingActionButtonThemeData(
  foregroundColor: accentColor,
  backgroundColor: primaryColor,
);

const Color darkPrimaryColor = Color(0xff64ffda);
const Color darkAccentColor = Color(0xff212121);

const TextTheme darkPrimaryTextTheme = TextTheme(
  bodyText1: TextStyle(
    color: darkAccentColor,
  ),
  bodyText2: TextStyle(
    color: darkAccentColor,
  ),
  button: TextStyle(
    color: darkAccentColor,
  ),
  caption: TextStyle(
    color: darkAccentColor,
  ),
  headline1: TextStyle(
    color: darkAccentColor,
  ),
  headline2: TextStyle(
    color: darkAccentColor,
  ),
  headline3: TextStyle(
    color: darkAccentColor,
  ),
  headline4: TextStyle(
    color: darkAccentColor,
  ),
  headline5: TextStyle(
    color: darkAccentColor,
  ),
  headline6: TextStyle(
    color: darkAccentColor,
  ),
  subtitle1: TextStyle(
    color: darkAccentColor,
  ),
  subtitle2: TextStyle(
    color: darkAccentColor,
  ),
);

const TextTheme darkAccentTextTheme = TextTheme(
  bodyText1: TextStyle(
    color: darkPrimaryColor,
  ),
  bodyText2: TextStyle(
    color: darkPrimaryColor,
  ),
  button: TextStyle(
    color: darkPrimaryColor,
  ),
  caption: TextStyle(
    color: darkPrimaryColor,
  ),
  headline1: TextStyle(
    color: darkPrimaryColor,
  ),
  headline2: TextStyle(
    color: darkPrimaryColor,
  ),
  headline3: TextStyle(
    color: darkPrimaryColor,
  ),
  headline4: TextStyle(
    color: darkPrimaryColor,
  ),
  headline5: TextStyle(
    color: darkPrimaryColor,
  ),
  headline6: TextStyle(
    color: darkPrimaryColor,
  ),
  subtitle1: TextStyle(
    color: darkPrimaryColor,
  ),
  subtitle2: TextStyle(
    color: darkPrimaryColor,
  ),
);

const AppBarTheme darkPrimaryAppBarTheme = AppBarTheme(
  color: darkPrimaryColor,
  actionsIconTheme: darkPrimaryIconTheme,
  iconTheme: darkPrimaryIconTheme,
  textTheme: darkPrimaryTextTheme,
);

const IconThemeData darkPrimaryIconTheme = IconThemeData(
  color: darkAccentColor,
);

const IconThemeData darkAccentIconTheme = IconThemeData(
  color: darkPrimaryColor,
);

const FloatingActionButtonThemeData darkFloatingTheme =
    FloatingActionButtonThemeData(
  foregroundColor: darkAccentColor,
  backgroundColor: darkPrimaryColor,
);
