import 'package:flutter/material.dart';

class UserBudgetStaticWidget extends StatelessWidget {
  final String balance;
  final String trend;

  const UserBudgetStaticWidget({
    Key? key,
    required this.balance,
    required this.trend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      trailing: Image.asset(
        'assets/home/cyrptobackground.png',
        fit: BoxFit.contain,
      ),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bakiyeniz',
              style: textTheme.displayLarge,
            ),
            const SizedBox(height: 10),
            Text(
              balance,
              style: textTheme.titleLarge,
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.arrow_drop_up,
              color: Colors.greenAccent,
              size: 30,
            ), // Yukarı ok simgesi
            const SizedBox(width: 4), // Boşluk ekleyin
            Text(trend, style: textTheme.displayMedium),
          ],
        ),
      ),
    );
  }
}
