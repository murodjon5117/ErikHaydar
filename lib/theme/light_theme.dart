import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../util/color_resources.dart';
import '../util/dimensions.dart';

ThemeData light = ThemeData(
  fontFamily: 'Inter',
  
  primaryColor: ColorResources.COLOR_PPIMARY,
  brightness: Brightness.light,
  cardColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: ColorResources.COLOR_PPIMARY, // Your accent color
  ),
  shadowColor: ColorResources.COLOR_PPIMARY,
  hoverColor: ColorResources.COLOR_PPIMARY,
  focusColor: ColorResources.COLOR_PPIMARY,
  hintColor: ColorResources.COLOR_PPIMARY,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    textStyle: const TextStyle(color: Colors.black),
  )),
  listTileTheme:
      const ListTileThemeData(selectedColor: ColorResources.COLOR_PPIMARY),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shadowColor: ColorResources.COLOR_WHITE,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  textTheme: const TextTheme(
    button: TextStyle(color: Colors.white),
    headline1: TextStyle(
        fontWeight: FontWeight.w300, fontSize: Dimensions.FONT_SIZE_14),
    headline2: TextStyle(
        fontWeight: FontWeight.w400, fontSize: Dimensions.FONT_SIZE_14),
    headline3: TextStyle(
        fontWeight: FontWeight.w500, fontSize: Dimensions.FONT_SIZE_14),
    headline4: TextStyle(
        fontWeight: FontWeight.w600, fontSize: Dimensions.FONT_SIZE_14),
    headline5: TextStyle(
        fontWeight: FontWeight.w700, fontSize: Dimensions.FONT_SIZE_14),
    headline6: TextStyle(
        fontWeight: FontWeight.w800, fontSize: Dimensions.FONT_SIZE_14),
    caption: TextStyle(
        fontWeight: FontWeight.w900, fontSize: Dimensions.FONT_SIZE_14),
    subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
    bodyText2: TextStyle(fontSize: 12.0),
    bodyText1: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ),
);
