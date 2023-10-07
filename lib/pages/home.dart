import 'package:flutter/material.dart';
import 'package:tradeapp/pages/widget/custom_app_bar.dart';
import 'package:tradeapp/pages/widget/home/analysis_list_view.dart';
import 'package:tradeapp/pages/widget/home/announcement_slider.dart';
import 'package:tradeapp/pages/widget/home/budget_static.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(),
        appBar: const CustomAppBar(),
        bottomNavigationBar:  BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.home)),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.stacked_line_chart_outlined)),

              FloatingActionButton(onPressed: (){},child: const Icon(Icons.upcoming),),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.zoom_out_rounded)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.abc_outlined)),

            ],
          ),
        ),
        body: ListView(
          children: const [
            AnnouncementsSliderWidget(),
            UserBudgetStaticWidget(
              balance: '9308TRY',
              trend: '1.98% 4 Gündür Yükseliştesiniz',
            ),
            SizedBox(
              height: 300, // İlgili widgetın yüksekliğini belirtin
              child: AnalysisListView(title: ''),
            ),
          ],
        ));
  }
}
