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
    TextStyle textStyle = Theme.of(context).textTheme.displaySmall!;
    double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cryptoData.name,
          style: textStyleLarge,
        ),
        actions: const [
          // IconButton(
          //     onPressed: () {
          //       final snackBar = SnackBar(
          //         content: Center(
          //             child: Text(
          //           '${cryptoData.name} Notification Created.',
          //           style: textStyleMedium,
          //         )),
          //         action: SnackBarAction(
          //           label: 'Done!', // Eylemin metni
          //           onPressed: () {},
          //         ),
          //       );

          //       // SnackBar'ı göstermek için ScaffoldMessenger kullanılır
          //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //     },
          //     icon: const Icon(Icons.notification_add))
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
              decoration: BoxDecoration(
                color: themeData.secondaryHeaderColor,
                borderRadius:
                    BorderRadius.circular(20.0), // Radius eklemek için
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Endeks: ${cryptoData.exchange}",
                        style: textStyleMedium,
                      ),
                     
                      trailing: Text(
                        "Bölge: ${cryptoData.screener}",
                        style: textStyleMedium,
                      ),
                    ),
                    ListTile(
                    
                      leading: CircleAvatar(
                        radius: deviceWidth <= 410 ? 10 : 20,
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
                      title: Text(
                        cryptoData.name,
                        style: textStyle.copyWith(fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        cryptoData.symbol,
                        style: textStyle.copyWith(fontSize: 11),
                      ),
                      trailing: SizedBox(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${cryptoData.recommendation == "NEUTRAL" ? "NÖTR" : cryptoData.recommendation} ",
                              style: TextStyle(
                                fontSize: 10,
                                color: cryptoData.recommendation
                                        .contains("AL")
                                    ? Colors.greenAccent
                                    : cryptoData.recommendation
                                            .contains("SAT")
                                        ? Colors.redAccent
                                        : Colors.grey,
                              ),
                              overflow: TextOverflow
                                  .ellipsis, // Metni kesme (ellipsis) ekledik
                            ),
                            const Icon(
                              Icons.arrow_drop_up,
                              color: Colors.greenAccent,
                              size: 20, // Simge boyutunu küçülttük
                            ),
                            Text(
                              "${cryptoData.buy} ",
                              style: textStyle,
                            ),
                            const Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                              size: 15, // Simge boyutunu küçülttük
                            ),
                            Text(
                              " ${cryptoData.neutral}",
                              style: textStyle,
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.redAccent,
                              size: 20, // Simge boyutunu küçülttük
                            ),
                            Text(
                              "${cryptoData.sell}",
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                    )
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
