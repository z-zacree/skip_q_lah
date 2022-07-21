// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ClientDetail {
  static String name = 'Lunar Ice Cream';

  static Map<int, double> estimatedWaitingTime = {
    1: 5,
    2: 10,
    3: 15,
  };
}

class AppColors {
  static Color oldLace = const Color.fromARGB(255, 255, 248, 235);
  static Color peachCrayola = const Color.fromARGB(255, 255, 196, 155);
  static Color cadetBlueCrayola = const Color.fromARGB(255, 173, 182, 196);
  static Color charcoal = const Color.fromARGB(255, 41, 76, 96);
  static Color oxfordBlue = const Color.fromARGB(255, 0, 27, 46);
}

class ThemeProvider {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.charcoal,
    primaryColorLight: Colors.white,
    primaryColorDark: Colors.black,
    backgroundColor: AppColors.oldLace,
    scaffoldBackgroundColor: AppColors.oldLace,
    colorScheme: ColorScheme.light(primary: AppColors.peachCrayola),
    fontFamily: 'Comfortaa',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.oxfordBlue),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.peachCrayola,
      foregroundColor: Colors.black,
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Colors.black,
      selectedTileColor: AppColors.peachCrayola.withAlpha(40),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.peachCrayola,
    primaryColorLight: Colors.black,
    primaryColorDark: Colors.white,
    backgroundColor: AppColors.oxfordBlue,
    scaffoldBackgroundColor: AppColors.oxfordBlue,
    colorScheme: ColorScheme.dark(primary: AppColors.charcoal),
    fontFamily: 'Comfortaa',
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: AppColors.oldLace),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.charcoal,
      foregroundColor: Colors.white,
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Colors.white,
      selectedTileColor: AppColors.charcoal.withAlpha(40),
    ),
  );
}

typedef JsonResponse = Map<String, dynamic>;
