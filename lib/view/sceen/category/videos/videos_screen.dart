import 'package:erik_haydar/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) => DefaultTabController(
        length: value.filmsCategory.length,
        child: Scaffold(
          backgroundColor: ColorResources.COLOR_WHITE,
          appBar: AppBar(
            title: TabBar(
              indicatorWeight: 3,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              labelColor: ColorResources.COLOR_PPIMARY,
              indicatorColor: ColorResources.COLOR_PPIMARY,
              unselectedLabelColor: ColorResources.COLOR_BLACK,
              isScrollable: true,
              tabs: value.tabs,
            ),
            titleSpacing: 0,
            centerTitle: false,
            elevation: 0.0,
            backgroundColor: ColorResources.COLOR_WHITE,
          ),
          body: TabBarView(
            children: value.generalWidgets,
          ),
        ),
      ),
    );
  }
}
