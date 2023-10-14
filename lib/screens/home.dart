import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradeapp/models/notification.dart';
import 'package:tradeapp/screens/auth/login.dart';
import 'package:tradeapp/services/api_services.dart';
import 'package:tradeapp/widget/custom_bottom_app_bar.dart';
import 'package:tradeapp/widget/home/analysis_list_view.dart';
import 'package:tradeapp/widget/home/announcement_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<NotificationModel>>? futureNotificationData;
  final Duration refreshRate = const Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    futureNotificationData = ApiService().userNotification();
  }

  Future<String?> getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final GlobalKey<ScaffoldState> scaffoldKey =
        GlobalKey<ScaffoldState>(); // Anahtar oluştur

    return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  "Notification",
                  style: textTheme.displayMedium,
                ),
                const Icon(
                  Icons.check,
                  color: Colors.greenAccent,
                )
              ]),
              Expanded(
                child: FutureBuilder<List<NotificationModel>>(
                  future: futureNotificationData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Bekleme durumunda bir yükleniyor gösterebilirsiniz.
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Hata durumunda bir hata mesajı gösterebilirsiniz.
                    } else {
                      // Veri başarıyla geldiyse, bildirimleri listeleyebilirsiniz.
                      final notifications = snapshot.data;

                      return ListView.builder(
                        itemCount: notifications?.length,
                        itemBuilder: (context, index) {
                          final notification = notifications?[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/home/userprofileicon.jpg'),
                            ),
                            title: Text(
                              notification?.title ?? '',
                              style: textTheme.displayMedium,
                            ),
                            subtitle: Text(
                              notification?.text ?? '',
                              style: textTheme.displaySmall!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                            ),
                            // Diğer bildirim özelliklerini burada görüntüleyebilirsiniz.
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: const SizedBox(),
          title: Text(
            'Trading Analyser',
            style: textTheme.displayLarge,
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  getAuthToken().then((authToken) {
                    if (authToken != null && authToken.isNotEmpty) {
                      scaffoldKey.currentState?.openDrawer(); // Çekmeceyi açar
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
                },
                icon: const Icon(Icons.notifications_none)),
          ],
        ),
        bottomNavigationBar: const CustomBottomAppBar(),
        body: ListView(
          children: const [
            AnnouncementsSliderWidget(),
            AnalysisListView(title: ''),
          ],
        ));
  }
}
