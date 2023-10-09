import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/screens/object_detail.dart';
import 'package:tradeapp/screens/profile.dart';
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
              "/login": (context) =>
                  authService.authToken != null ? const HomePage() : const LoginPage(),
              "/object_detail": (context) =>
                  authService.authToken != null ? const ObjectDetail() : const LoginPage(),
              "/profile": (context) =>
                  authService.authToken != null ? const ProfileDetail() : const LoginPage(),
            },
          );
        },
      ),
    );
  }
}