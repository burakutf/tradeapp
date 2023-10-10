import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.stacked_line_chart_outlined)),
       
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notification_add)),
          IconButton(
              
              onPressed: () {
                Navigator.of(context).pushNamed("/profile");
              },
              icon: const Icon(Icons.person_2_outlined)),
        ],
      ),
    );
  }
}
