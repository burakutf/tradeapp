import 'package:flutter/material.dart';
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/screens/home.dart';
import 'package:tradeapp/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoAnimationPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });
  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  if (ModalRoute.of(context)?.settings.name != '/') {
                    Navigator.of(context).push(NoAnimationPageRoute(
                      builder: (_) => const HomePage(),
                      settings: const RouteSettings(name: '/'),
                    ));
                  }
                },
                icon: const Icon(Icons.home)),
            IconButton(
              icon: const Icon(Icons.person_2_outlined),
              onPressed: () {
                if (ModalRoute.of(context)?.settings.name != '/profile') {
                  getAuthToken().then((authToken) {
                    if (authToken != null && authToken.isNotEmpty) {
                      Navigator.of(context).push(NoAnimationPageRoute(
                        builder: (_) => const ProfileDetail(),
                        settings: const RouteSettings(name: '/profile'),
                      ));
                    } else {
                      if (ModalRoute.of(context)?.isActive ?? false) {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const LoginPage(),
                          transitionDuration: const Duration(seconds: 0),
                        ));
                      }
                    }
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
