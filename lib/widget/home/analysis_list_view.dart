import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tradeapp/models/crypto_data.dart';
import 'package:tradeapp/services/api_services.dart';

class AnalysisListView extends StatelessWidget {
  final String title;

  const AnalysisListView({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(border: Border()),
              child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.lightGreen,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Kripto"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Hisse"),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  AnalaysisListTab(screener: "crypto"),
                  AnalaysisListTab(
                    screener: "share",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnalaysisListTab extends StatefulWidget {
  final String screener;

  const AnalaysisListTab({super.key, required this.screener});

  @override
  // ignore: library_private_types_in_public_api
  _AnalaysisListTabState createState() => _AnalaysisListTabState();
}

class _AnalaysisListTabState extends State<AnalaysisListTab> {
  Future<List<CryptoData>>? futureCryptoData;
  final Duration refreshRate = const Duration(minutes: 1);
  TextEditingController searchController = TextEditingController();
  String selectedTimePeriod = '1m';
  late Timer _timer; // Timer nesnesini tanımlayın

  @override
  void initState() {
    super.initState();
    futureCryptoData = ApiService().getCryptoData(
      searchTerm: searchController.text,
      timePeriod: selectedTimePeriod,
      screener: widget.screener,
    );

    startPeriodicTimer();
  }

  void startPeriodicTimer() {
    _timer = Timer.periodic(refreshRate, (Timer timer) {
      if (mounted) {
        // Mounted kontrolü ekleyin
        setState(() {
          final currentSelectedTimePeriod = selectedTimePeriod;
          futureCryptoData = ApiService().getCryptoData(
            searchTerm: searchController.text,
            timePeriod: currentSelectedTimePeriod,
            screener: widget.screener,
          );
        });
      }
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      futureCryptoData = ApiService().getCryptoData(
        searchTerm: searchController.text,
        timePeriod: selectedTimePeriod,
        screener: widget.screener,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Timer'ı dispose edin
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).primaryTextTheme.titleMedium!;
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Zaman periyodu seçimi için bir DropdownButtonFormField ekleyin

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 100,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: themeData.scaffoldBackgroundColor,
                    value: selectedTimePeriod,
                    onChanged: (String? value) {
                      setState(() {
                        selectedTimePeriod = value ?? '1m';
                      });
                      _refreshData();
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                themeData.secondaryHeaderColor), // Border rengi
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color:
                                themeData.secondaryHeaderColor), // Border rengi
                      ),
                      filled: true, // Arkaplanı doldur
                      fillColor:
                          themeData.scaffoldBackgroundColor, // Arkaplan rengi
                    ),
                    isExpanded:
                        true, // Dropdown penceresini tüm ekranı kaplayacak şekilde genişlet
                    items: ['1m', '5m', '15m', '1h'].map((String period) {
                      return DropdownMenuItem<String>(
                        value: period,
                        child: Center(
                          child: Text(
                            period,
                            style: textStyle,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                // TODO search barı falan küçült
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        _refreshData(); // Her metin değiştiğinde verileri yeniden çek
                      },
                      decoration: InputDecoration(
                        labelText: 'Arama',
                        labelStyle: textStyle,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Yuvarlanmış kenarlar
                          borderSide:
                              BorderSide(color: themeData.secondaryHeaderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Yuvarlanmış kenarlar
                          borderSide: BorderSide(color: themeData.primaryColor),
                        ),
                        filled: true, // Arkaplanı doldur
                        fillColor:
                            themeData.scaffoldBackgroundColor, // Arkaplan rengi
                      ),
                      cursorColor: themeData.primaryColor,
                      style: const TextStyle(
                          color: Colors.white), // Girilen metnin rengi
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: FutureBuilder<List<CryptoData>>(
                future: futureCryptoData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        CryptoData cryptoData = snapshot.data![index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xff19376D),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
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
                                style: textStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                cryptoData.symbol,
                                style: textStyle,
                              ),
                              trailing: SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${cryptoData.recommendation == "NEUTRAL" ? "NÖTR" : cryptoData.recommendation} ",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: cryptoData.recommendation
                                                .contains("BUY")
                                            ? Colors.greenAccent
                                            : cryptoData.recommendation
                                                    .contains("SELL")
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
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
