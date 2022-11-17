import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/slider_model/slider_model.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/sceen/home/film/film_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/color_resources.dart';
import '../../../util/images.dart';

class HomeCategoriesScreen extends StatelessWidget {
  final HomeModel films;
  HomeCategoriesScreen({super.key, required this.films});
  double setPadding(int index) {
    if (index == 0) {
      return 20;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 20),
            child: Text(
              films.name ?? '',
              style: boldTitle,
            ),
          ),
          SizedBox(
            height: 210,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              itemCount: films.films?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                      top: 12, bottom: 12, left: setPadding(index)),
                  child: FilmGridItem(item: films.films?[index] ?? Films())),
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                width: 12,
              ),
            ),
          ),
        ]);
  }
}
