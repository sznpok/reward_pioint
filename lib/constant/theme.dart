import 'package:flutter/material.dart';

import 'color_constant.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(color: primaryColor),
    backgroundColor: const Color(0xff30309E),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        fixedSize: const Size.fromHeight(42),
      ),
    ),
  );
}
