import 'package:carousel_slider/carousel_slider.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/util/base_functions.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/detail_film/detail_film_screen.dart';
import 'package:erik_haydar/view/sceen/detail_music/detail_music_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SliderScreen extends StatelessWidget {
  const SliderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => CarouselSlider.builder(
        itemCount: value.slider.length,
        itemBuilder: (context, index, realIndex) {
          return GestureDetector(
            onTap: () async {
              if ((value.slider[index].film == null)) {
                String url = value.slider[index].link ?? '';
                print(url);
                // launchUrlStart(url: value.slider[index].link ?? '');
                launchUrlStart(url: 'https://t.me/kunuzofficial');
              } else {
                if (value.slider[index].film?.isMusic == 1) {
                  pushNewScreen(context,
                      screen: DetailMusicScreen(
                          slug: value.slider[index].film?.slug ?? '',
                          image: value.slider[index].film?.image ?? ''),
                      withNavBar: false);
                } else {
                  pushNewScreen(context,
                      screen: DetailFilmScreen(
                          slug: value.slider[index].film?.slug ?? '',
                          image: value.slider[index].film?.image ?? ''),
                      withNavBar: false);
                }
              }
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BaseUI().imageNetwork(value.slider[index].url)),
          );
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
