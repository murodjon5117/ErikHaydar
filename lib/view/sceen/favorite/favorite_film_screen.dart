import 'package:erik_haydar/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
import '../home/film/film_grid_item.dart';

class FavoriteFilmScreen extends StatefulWidget {
  const FavoriteFilmScreen({super.key});

  @override
  State<FavoriteFilmScreen> createState() => _FavoriteFilmScreenState();
}

class _FavoriteFilmScreenState extends State<FavoriteFilmScreen> {

  double isEvenLeft(int index) {
    if (index % 2 == 0) {
      return 20.0;
    } else {
      return 6.0;
    }
  }

  double isEvenRight(int index) {
    if (index % 2 == 0) {
      return 6.0;
    } else {
      return 20.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
        builder: (context, value, child) => Stack(
              children: [
                NotificationListener(
                  onNotification: _scrollNotification,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 8),
                      child: gridList(context, value)),
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: value.isPagingLoading
                        ? const LinearProgressIndicator(
                            backgroundColor: ColorResources.COLOR_GREY,
                            color: ColorResources.COLOR_PPIMARY,
                            minHeight: 4,
                          )
                        : const SizedBox())
              ],
            ));
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<FavoriteProvider>(context, listen: false).isPaging()) {
      Provider.of<FavoriteProvider>(context, listen: false)
          .getFavoriteFilms(true);
    }
    return true;
  }

  Widget gridList(BuildContext context, FavoriteProvider value) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 201,
        crossAxisCount: 2,
      ),
      itemCount: value.films.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            top: 9,
            bottom: 9,
            left: isEvenLeft(index),
            right: isEvenRight(index)),
        child: FilmGridItem(item: value.films[index]),
      ),
    );
  }
}
