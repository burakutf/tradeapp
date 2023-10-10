import 'package:flutter/material.dart';
import 'package:tradeapp/models/crypto_data.dart';

class ObjectDetail extends StatelessWidget {
  final CryptoData cryptoData;

  const ObjectDetail({super.key, required this.cryptoData});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleLarge = Theme.of(context).textTheme.displayLarge!;
    TextStyle textStyleMedium = Theme.of(context).textTheme.displayMedium!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cryptoData.name,
          style: textStyleLarge,
        ),
        actions: [
          IconButton(onPressed: () {
        final snackBar = SnackBar(
          content:  Center(child: Text('${cryptoData.name} Bildirimi Oluşturuldu.',style: textStyleMedium,)),
          action: SnackBarAction(
            label: 'Tamam', // Eylemin metni
            onPressed: () {
         
            },
          ),
        );

        // SnackBar'ı göstermek için ScaffoldMessenger kullanılır
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }, icon: const Icon(Icons.notification_add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${cryptoData.name}',style: textStyleMedium,),
            Text('Symbol: ${cryptoData.symbol}',style: textStyleMedium,),
          ],
        ),
      ),
    );
  }
}
