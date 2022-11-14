import 'package:carousel_slider/carousel_slider.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => CarouselSlider.builder(
        itemCount: value.slider.length,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: BaseUI().imageNetwork(
                  'https://hamshira.biznesgoya.uz/uploads/images/film/8/preview-63623e500212e.png'));
        },
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          aspectRatio: 1.3,
          viewportFraction: 0.55,
          autoPlayInterval: const Duration(seconds: 8),
        ),
      ),
    );
  }
}
