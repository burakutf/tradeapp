import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
    
      title: Text(
        'BTCTURK',
        style: textTheme.displayLarge,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'TRY/USDT 30',
            style: textTheme.displaySmall,
          ),
        ),
   
      ],
    );
  }
}
