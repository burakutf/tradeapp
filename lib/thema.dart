import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData appTheme = ThemeData(
    
    primaryTextTheme:
        const TextTheme(titleMedium: TextStyle(color: Color(0xffEEEEEE))),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color?>((states) {
          // Durumları inceleyerek farklı renkler döndürebilirsiniz.
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue; // Basıldığında renk
          }
          return const Color(0xffEEEEEE); // Varsayılan renk
        }),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xff00ADB5)),
    drawerTheme: const DrawerThemeData(
        backgroundColor: Color(0xff393E46), shadowColor: Color(0xffEEEEEE)),
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        color: Color(0xffEEEEEE),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      displayMedium: TextStyle(
        color: Color(0xffEEEEEE),
        fontSize: 17,
        fontWeight: FontWeight.normal,
      ),
      displayLarge: TextStyle(
        color: Color(0xffEEEEEE),
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: Color(0xff00ADB5),
        fontSize: 35,
        fontWeight: FontWeight.w800,
      ),
      titleMedium: TextStyle(
        color: Color(0xff00ADB5),
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xff393E46),
    ),
    scaffoldBackgroundColor: const Color(0xff222831),
    primaryColor: const Color(0xffEEEEEE),
    secondaryHeaderColor: const Color(0xff393E46),
    colorScheme: ColorScheme.fromSeed(background: const Color(0xff00ADB5),seedColor: Colors.deepPurple),
    useMaterial3: true,
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff393E46)),
  );
}
