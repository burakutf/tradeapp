import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class AnnouncementsSliderWidget extends StatelessWidget {
  const AnnouncementsSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> sliderItems = [
      _buildSliderItem('assets/home/sliderbtc.jpg', context),
      _buildSliderItem('assets/home/sliderchart.jpg', context),
      _buildSliderItem('assets/home/sliderbtcdoor.jpg', context),
      _buildSliderItem('assets/home/sliderbtcworld.jpg', context),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CarouselSlider(
        items: sliderItems,
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          enlargeCenterPage: true,
          aspectRatio: 16 / 8,
          viewportFraction: 1,
        ),
      ),
    );
  }

  Widget _buildSliderItem(String imagePath, BuildContext context) {
    final Color borderColor = Theme.of(context).secondaryHeaderColor; 

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
