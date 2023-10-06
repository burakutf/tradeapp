import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
    disabledColor: Colors.red,
    primaryTextTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color?>((states) {
          // Durumları inceleyerek farklı renkler döndürebilirsiniz.
          if (states.contains(MaterialState.pressed)) {
            return Colors.red; // Basıldığında renk
          }
          return const Color(0xffa5d7e8); // Varsayılan renk
        }),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
          // Durumları inceleyerek farklı renkler döndürebilirsiniz.
          if (states.contains(MaterialState.pressed)) {
            return Colors.black; // Basıldığında renk
          }
          return Colors.green; // Varsayılan renk
        }),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xffa5d7e8)),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff0b2447), shadowColor: Color(0xffa5d7e8)),
    appBarTheme: const AppBarTheme(
      color: Color(0xff19376D),
    ),
    scaffoldBackgroundColor: const Color(0xff0b2447),
    primaryColor: const Color(0xff19376D),
    secondaryHeaderColor: Color.fromARGB(194, 91, 95, 111),
    useMaterial3: true,
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: Color.fromARGB(255, 236, 242, 244),
            fontWeight: FontWeight.bold,
            fontSize: 40,
            shadows: [BoxShadow(blurRadius: 6, offset: Offset(0, 1), spreadRadius: 2)]),
        displayLarge: TextStyle(
            color: Color.fromARGB(255, 236, 242, 244),
            fontWeight: FontWeight.bold,
            fontSize: 24,
            shadows: [BoxShadow(blurRadius: 6, offset: Offset(0, 1), spreadRadius: 2)]),
        displayMedium: TextStyle(
            fontSize: 18,
            color: Color(0xffa5d7e8),
            shadows: [BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 1), spreadRadius: 5)]),
        displaySmall: TextStyle(
            fontSize: 13,
            color: Color(0xffa5d7e8),
            shadows: [BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 1), spreadRadius: 5)]),
        labelSmall: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 104, 137, 148),
            shadows: [BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 1), spreadRadius: 5)])),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(error: Colors.red));
