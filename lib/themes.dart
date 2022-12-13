import 'package:flutter/material.dart';
enum ThemesEnum { dark, light }
class Themes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blueGrey
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white
  );
}