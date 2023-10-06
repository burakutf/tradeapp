import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        "MY WALLET",
        style: textTheme.displayLarge,
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_active)),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.power_settings_new_outlined,
              color: Theme.of(context).disabledColor,
            )),
      ],
    );
  }
}
