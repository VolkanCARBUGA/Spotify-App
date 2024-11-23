import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border(Color color)=> OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: color, width: 3)
  );
  static final darkThemeMode = ThemeData.dark().copyWith();
  static const scaffoldBackgroundColor = Pallete.backgroundColor;
  static final inputDecorationTheme = InputDecorationTheme(
    contentPadding: EdgeInsets.all(20),
      focusedBorder: _border(
        Pallete.borderColor
      ),
      enabledBorder: _border(
        Pallete.gradient2
      ),);
}
