import 'package:flutter/material.dart';
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO animasyonu kaldırdın fakat kullanıcı bulunduğu sayfadayken tekrar istek atabiliyor
class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const HomePage(),
                  transitionDuration: const Duration(seconds: 0),
                ));
              },
              icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.stacked_line_chart_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notification_add)),
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? authToken = prefs.getString('authToken');

              if (authToken != null && authToken.isNotEmpty) {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ProfileDetail(),
                  transitionDuration: const Duration(seconds: 0),
                ));
              } else {
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const LoginPage(),
                  transitionDuration: const Duration(seconds: 0),
                ));
              }
            },
            icon: const Icon(Icons.person_2_outlined),
          )
        ],
      ),
    );
  }
}
