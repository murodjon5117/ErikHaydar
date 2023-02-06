import 'package:erik_haydar/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/film/film_grid_item.dart';

class FilmSearchScreen extends StatefulWidget {
  final String query;

  const FilmSearchScreen({super.key, required this.query});
  @override
  State<FilmSearchScreen> createState() => _FilmSearchScreenState();
}

class _FilmSearchScreenState extends State<FilmSearchScreen> {
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
    return Consumer<SearchProvider>(
        builder: (context, value, child) => NotificationListener(
          onNotification: _scrollNotification,
          child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: gridList(context, value)),
        ));
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<SearchProvider>(context, listen: false).isPaging()) {
      Provider.of<SearchProvider>(context, listen: false)
          .getFilmsSearch(widget.query, true);
    }
    return true;
  }

  Widget gridList(BuildContext context, SearchProvider value) {
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
