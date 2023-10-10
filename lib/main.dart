import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/services/auth_services.dart';
import 'package:tradeapp/thema.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService()..fetchAuthToken(),
      child: Consumer<AuthService>(
        builder: (context, authService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppThemes.appTheme,
            routes: {
              "/": (context) => const HomePage(),
       
            },
          );
        },
      ),
    );
  }
}