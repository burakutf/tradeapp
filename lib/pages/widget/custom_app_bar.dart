import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu),
          style: Theme.of(context).iconButtonTheme.style,
        );
      }),
      title: Text(
        'BTCTURK',
        style: textTheme.displayLarge,
      ),
      actions: <Widget>[
        Text(
          'TRY/USDT 30',
          style: textTheme.displaySmall,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/home/userprofileicon.jpg'),
          ),
        ),
      ],
    );
  }
}
