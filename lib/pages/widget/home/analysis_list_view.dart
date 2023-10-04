import 'package:flutter/material.dart';

class AnalysisListView extends StatelessWidget {
  final String title;

  const AnalysisListView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Güçlü Al"),
                    ),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xff576CBC),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("Güçlü Sat"),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                MyTab(),
                MyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class CryptoData {
  final String name;
  final String symbol;
  final String image;
  final String price;
  final double changePercent;
  final Color changeColor;

  CryptoData({
    required this.name,
    required this.symbol,
    required this.image,
    required this.price,
    required this.changePercent,
    required this.changeColor,
  });
}

final List<CryptoData> cryptoList = [
  CryptoData(
    name: 'Bitcoin',
    symbol: 'BTC',
    image: 'https://bitcoin.org/img/icons/opengraph.png?1693519667',
    price: r'$60,890.02',
    changePercent: 6.08,
    changeColor: Colors.greenAccent,
  ),
    CryptoData(
    name: 'Etherium',
    symbol: 'ETC',
    image: 'https://images.youngplatform.com/coins/eth_light_3.png',
    price: r'$30,890.02',
    changePercent: 1.08,
    changeColor: Colors.redAccent,
  ),
      CryptoData(
    name: 'Tether',
    symbol: 'USDT',
    image: 'https://seeklogo.com/images/T/tether-usdt-logo-FA55C7F397-seeklogo.com.png',
    price: r'$20',
    changePercent: 3.38,
    changeColor: Colors.greenAccent,
  ),
];

class MyTab extends StatelessWidget {
  const MyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.titleMedium!;

    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        CryptoData cryptoData = cryptoList[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff19376D),
            ),
            child: ListTile(
              leading: Image(image: NetworkImage(cryptoData.image)),
              title: Text(
                cryptoData.name,
                style: textStyle,
              ),
              subtitle: Text(cryptoData.symbol, style: textStyle),
              trailing: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      cryptoData.price,
                      style: textStyle,
                    ),
                    Text(
                      '%${cryptoData.changePercent.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: cryptoData.changeColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
