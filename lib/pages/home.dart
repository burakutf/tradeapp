import 'package:flutter/material.dart';
import 'package:tradeapp/pages/widget/custom_app_bar.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    ThemeData tema = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          Text(
            "Hi Burak your balance",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const budgetWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 0),
            child: Row(
              children: [
                Text(
                  "Statistic",
                  style: tema.textTheme.displayMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 180),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          "View more",
                          style: TextStyle(color: tema.secondaryHeaderColor),
                        ),
                        Icon(Icons.chevron_right_outlined)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Card(
            color: Theme.of(context).secondaryHeaderColor,
            child: SizedBox(
              height: 300,
            ),
          )
        ],
      ),
    );
  }
}

class budgetWidget extends StatelessWidget {
  const budgetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).secondaryHeaderColor,
      child: SizedBox(
        height: 160,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Row(
                children: [
                  const Icon(Icons.currency_bitcoin_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "10.3250",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Icon(Icons.add_circle_outlined),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  const Icon(Icons.attach_money_outlined),
                  Text(
                    "404252.94 <> 0.23%",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Icon(
                    Icons.trending_down_outlined,
                    color: Theme.of(context).disabledColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 150,
                  child: ClipRRect(
                    child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "BUY",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const Icon(Icons.download_outlined)
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ClipRRect(
                    child: ElevatedButton(
                        style: Theme.of(context).elevatedButtonTheme.style,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SELL",
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const Icon(Icons.upload_outlined)
                          ],
                        )),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
