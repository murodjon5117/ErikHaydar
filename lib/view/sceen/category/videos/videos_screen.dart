import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/view/sceen/category/videos/item_videos_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';

class VideosScreen extends StatefulWidget {
  // final List<Items> list;

  const VideosScreen({super.key, });
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen>
    with TickerProviderStateMixin {
  List<Tab> _tabs = [];
  List<Widget> _generalWidgets = [];
  TabController? _tabController;

  @override
  void initState() {
    
    _tabs = getTabs(Provider.of<CategoryProvider>(context,listen: false).filmsCategory.length);
    _tabController = getTabController();

    super.initState();
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 0; i < count; i++) {
      _tabs.add(getTab(i));
    }
    return _tabs;
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  Tab getTab(int widgetNumber) {
    return Tab(
      text: Provider.of<CategoryProvider>(context,listen: false).filmsCategory[widgetNumber].name,
    );
  }

  List<Widget> getWidgets() {
    _generalWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _generalWidgets.add(getWidget(i));
    }
    return _generalWidgets;
  }

  Widget getWidget(int i) {
    return ItemVideosScreen(item: Provider.of<CategoryProvider>(context,listen: false).filmsCategory[i]);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: Provider.of<CategoryProvider>(context,listen: false).filmsCategory.length,
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
              tabs: _tabs,
              controller: _tabController),
          titleSpacing: 0,
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: ColorResources.COLOR_WHITE,
        ),
        body: TabBarView(

          controller: _tabController,
          children: getWidgets(),
        ),
      ),
    );
  }
}
