import 'package:flutter/material.dart';
import 'package:tradeapp/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryTextTheme: const TextTheme(titleMedium: TextStyle(color: Colors.white)),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStateProperty.resolveWith<Color?>((states) {
              // Durumları inceleyerek farklı renkler döndürebilirsiniz.
              if (states.contains(MaterialState.pressed)) {
                return Colors.blue; // Basıldığında renk
              }
              return const Color(0xffa5d7e8); // Varsayılan renk
            }),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xffa5d7e8)),
        drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xff19376d), shadowColor: Color(0xffa5d7e8)),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            color: Color(0xffa5d7e8),
            fontSize: 9,
            fontWeight: FontWeight.normal,
          ),
          displayMedium: TextStyle(
            color: Color(0xffa5d7e8),
            fontSize: 17,
            fontWeight: FontWeight.normal,
          ),
          displayLarge: TextStyle(
            color: Color(0xffa5d7e8),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: Color(0xffa5d7e8),
            fontSize: 35,
            
            fontWeight: FontWeight.w800,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xff19376D),
        ),
        scaffoldBackgroundColor: const Color(0xff0b2447),
        primaryColor: const Color(0xffa5d7e8),
        secondaryHeaderColor: const Color(0xff576CBC),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true, bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xff19376D)),
      ),
      home: const HomePage(),
    );
  }
}

