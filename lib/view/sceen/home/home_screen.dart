import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/sceen/home/home_categories.dart';
import 'package:erik_haydar/view/sceen/home/music/music_item.dart';
import 'package:erik_haydar/view/sceen/home/music/music_list.dart';
import 'package:erik_haydar/view/sceen/home/slider/slider_2.dart';
import 'package:erik_haydar/view/sceen/home/slider/slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../util/dimensions.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        Provider.of<HomeProvider>(context, listen: false).getSliderData();
        Provider.of<HomeProvider>(context, listen: false).getHomeFilm();
        Provider.of<HomeProvider>(context, listen: false).getHomeMusic();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      key: drawerGlobalKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
                onTap: () {}, child: SvgPicture.asset(Images.notif_icon)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
                onTap: () {
                  pushNewScreen(context,
                      screen: SearchScreen(), withNavBar: false);
                },
                child: SvgPicture.asset(Images.searchIcon)),
          )
        ],
        backgroundColor: ColorResources.COLOR_WHITE,
        title: ListTile(
          minLeadingWidth: 0,
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(Images.user_icon),
          title: Text(
            getTranslated('hello', context),
            style: textButtonTextStyle,
          ),
          subtitle: Text(
            Provider.of<UserDataProvider>(context, listen: false).getName(),
            style: boldTitle,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (p0, p1) => Consumer<HomeProvider>(
            builder: (context, value, child) => RefreshIndicator(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: p1.maxHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const SliderScreen(),
                      const SizedBox(
                        height: 35,
                      ),
                      HomeListsScreen(
                          list: value.homeDataList, music: value.homeMusicList),
                    ],
                  ),
                ),
              ),
              onRefresh: () async {
                value.getHomeFilm();
                value.getSliderData();
                value.getHomeMusic();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomeListsScreen extends StatelessWidget {
  final List<HomeModel> list;
  final List<MusicModel> music;

  const HomeListsScreen({super.key, required this.list, required this.music});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorResources.COLOR_WHITE,
        boxShadow: [
          BoxShadow(
            color: ColorResources.COLOR_EBE9E9,
            blurRadius: 3.0,
            spreadRadius: 1.0,
          )
        ],
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return HomeCategoriesScreen(
                films: list[index],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 20),
            child: Text(
              getTranslated('musics', context),
              style: boldTitle,
            ),
          ),
          HomeMusicList(list: music),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
