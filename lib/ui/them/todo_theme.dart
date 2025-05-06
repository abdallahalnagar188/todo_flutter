import 'package:flutter/material.dart';

class TodoTheme {
  static final Color appColor = Color(0xff003b73);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appColor,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.black87
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 28,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xffB7935F),
      primary: Color(0xff003b73),
      onPrimary: Colors.white,
      secondary: Color(0xff006496),
      onSecondary: Colors.black,
    ),
  );
}
