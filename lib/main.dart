import 'package:flutter/material.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/screens/profile.dart';
import 'package:tradeapp/thema.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppThemes.appTheme,
      routes: {
        "/": (context) =>  const HomePage(),
        '/profile': (context) => const ProfileDetail(),
      
      },
    );
  }
}