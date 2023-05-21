import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/styles/app_colors.dart';
import 'package:todo_app/styles/text_styles.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
      primaryColor: lightColor,
      scaffoldBackgroundColor: lightGreenColor,
      textTheme: TextTheme(
        bodySmall: Roboto12BBlack(),
        bodyMedium: Poppins18Light(),
        bodyLarge: Poppins22White(),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: lightColor,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white, size: 30)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: lightColor,
        unselectedItemColor: Colors.grey,
      ));
  static ThemeData darkTheme = ThemeData(
      primaryColor: lightColor,
      scaffoldBackgroundColor: darkColor,
      textTheme: TextTheme(
        bodySmall: Roboto12BBlack(),
        bodyMedium: Poppins18Light(),
        bodyLarge: Poppins22White(),
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: lightColor,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white, size: 30)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightDarkColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: lightColor,
        unselectedItemColor: Colors.white,
      ));
}
