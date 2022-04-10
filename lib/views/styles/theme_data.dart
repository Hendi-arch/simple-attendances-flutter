import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  final base = ThemeData().textTheme;
  return ThemeData(
    textTheme: TextTheme(
      headline1: base.headline1?.copyWith(fontSize: 96, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300),
      headline2: base.headline2?.copyWith(fontSize: 60, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300),
      headline3: base.headline3?.copyWith(fontSize: 48, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),
      headline4: base.headline4?.copyWith(fontSize: 34, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300),
      headline5: base.headline5?.copyWith(fontSize: 24, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),
      headline6: base.headline6?.copyWith(fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500),
      subtitle1: base.subtitle1?.copyWith(fontSize: 16, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
      subtitle2: base.subtitle2?.copyWith(fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w500),
      bodyText1: base.bodyText1?.copyWith(fontSize: 16, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),
      bodyText2: base.bodyText2?.copyWith(fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),
      button: base.button?.copyWith(fontSize: 14, fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
      caption: base.caption?.copyWith(fontSize: 12, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400),
      overline: base.overline?.copyWith(fontSize: 10, fontStyle: FontStyle.normal, fontWeight: FontWeight.w400, letterSpacing: -0.3),
    ),
    primarySwatch: Colors.blue,
  );
}
