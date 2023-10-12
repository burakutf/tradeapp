import 'package:flutter/material.dart';
import 'package:tradeapp/models/crypto_data.dart';

class ObjectDetail extends StatelessWidget {
  final CryptoData cryptoData;

  const ObjectDetail({super.key, required this.cryptoData});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleLarge = Theme.of(context).textTheme.displayLarge!;
    TextStyle textStyleMedium = Theme.of(context).textTheme.displayMedium!;
    TextStyle textStyleSmall = Theme.of(context).textTheme.displaySmall!;
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cryptoData.name,
          style: textStyleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Center(
                      child: Text(
                    '${cryptoData.name} Notification Created.',
                    style: textStyleMedium,
                  )),
                  action: SnackBarAction(
                    label: 'Done!', // Eylemin metni
                    onPressed: () {},
                  ),
                );

                // SnackBar'ı göstermek için ScaffoldMessenger kullanılır
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: const Icon(Icons.notification_add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(
                  16.0), // İhtiyaca göre kenar boşluğunu ayarlayın
              child: Stack(
                alignment: Alignment
                    .center, // Stack içindeki elemanları merkeze hizala
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(16.0), // Resim için radius
                    child: const Image(
                      image: AssetImage("assets/home/object_detail.jpg"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Column içindeki elemanları ortala
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage(
                              cryptoData.image ??
                                  "https://cdn-icons-png.flaticon.com/512/5968/5968260.png",
                            ),
                            fit: BoxFit
                                .cover, // Resmi CircleAvatar'a sığdırmak için fit kullanın
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          cryptoData.name,
                          style: textStyleLarge,
                          textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          cryptoData.symbol,
                          style: textStyleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          Container(
                        margin: const EdgeInsets.all(16.0),
                        height: 300,
                        decoration: BoxDecoration(
                          color: themeData.secondaryHeaderColor,
                          borderRadius: BorderRadius.circular(
                              20.0), // Radius eklemek için
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(
                                  "What is Lorem Ipsum?",
                                  style: textStyleMedium,
                                ),
                                subtitle: Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                  style: textStyleSmall,
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
