import 'package:flutter/material.dart';
import 'package:tradeapp/widget/custom_app_bar.dart';
import 'package:tradeapp/widget/custom_bottom_app_bar.dart';
import 'package:tradeapp/widget/home/analysis_list_view.dart';
import 'package:tradeapp/widget/home/announcement_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: const CustomAppBar(),
        bottomNavigationBar: const CustomBottomAppBar(),
        body: ListView(
          children: const [
            AnnouncementsSliderWidget(),
            AnalysisListView(title: ''),
          ],
        ));
  }
}
