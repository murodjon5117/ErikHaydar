import 'dart:math';

import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/provider/home_provider/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SliderScreen2 extends StatefulWidget {
  const SliderScreen2({super.key});

  @override
  State<SliderScreen2> createState() => _SliderScreen2State();
}

class _SliderScreen2State extends State<SliderScreen2> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 280,
        width: 220,
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: PageView.builder(
                itemCount: value.slider.length,
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    child: Container(
                      color: Colors.red,
                    ),
                    animation: _pageController,
                    builder: (context, child) {
                      double values = 0.0;
                      if (_pageController.position.haveDimensions) {
                        values = index.toDouble() - (_pageController.page ?? 0);
                        values = (values * 0.038).clamp(-1, 1);
                        print("value $values index $index");
                      }
                      return Transform.rotate(
                        angle: pi * values,
                        child: carouselCard(value.slider[index]),
                      );
                    },
                  ); //carouselView(value.slider, index);
                }),
          ),
        ),
      ),
    );
  }

  Widget carouselView(List<SliderModel> dataList, int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double values = 0.0;
        if (_pageController.position.haveDimensions) {
          values = index.toDouble() - (_pageController.page ?? 0);
          values = (values * 0.038).clamp(-1, 1);
          print("value $values index $index");
        }
        return Transform.rotate(
          angle: pi * values,
          child: carouselCard(dataList[index]),
        );
      },
    );
  }

  Widget carouselCard(SliderModel data) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                  image: NetworkImage(
                    data.url ?? '',
                  ),
                  fit: BoxFit.fill),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 4), blurRadius: 4, color: Colors.black26)
              ]),
        ),
      ),
    );
  }
}
