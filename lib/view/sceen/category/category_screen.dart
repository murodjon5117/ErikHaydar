import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/category/musics/category_music.dart';
import 'package:erik_haydar/view/sceen/category/videos/videos_screen.dart';
import 'package:erik_haydar/view/sceen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
// Here you can write your code
        Provider.of<CategoryProvider>(context, listen: false)
            .getFilmsCategory();
        Provider.of<CategoryProvider>(context, listen: false).getFilterType();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, value, child) => DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ColorResources.COLOR_WHITE,
          appBar: AppBar(
            centerTitle: false,
            elevation: 0.0,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                    onTap: () {
                      pushNewScreen(context, screen: SearchScreen(),withNavBar: false);
                    },
                    child: SvgPicture.asset(Images.searchIcon)),
              )
            ],
            backgroundColor: ColorResources.COLOR_WHITE,
            title: Text(
              getTranslated('category', context),
              style: boldTitlePhone.copyWith(fontSize: Dimensions.FONT_SIZE_24),
            ),
            bottom: TabBar(
              isScrollable: false,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              labelColor: ColorResources.COLOR_WHITE,
              unselectedLabelColor: ColorResources.COLOR_BLACK,
              splashBorderRadius: BorderRadius.circular(50),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: ColorResources
                      .COLOR_PPIMARY), //Change background color from here
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Text(getTranslated('videos', context)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Text(getTranslated('musics', context)),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const VideosScreen(),
              CategoryMusic(),
            ],
          ),
          // body: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       // const SizedBox(
          //       //   height: 18,
          //       // ),
          //       // Container(
          //       //   decoration: BoxDecoration(
          //       //       color: ColorResources.COLOR_F4F4F4,
          //       //       borderRadius: BorderRadius.circular(50)),
          //       //   child: TabBar(
          //       //     padding: const EdgeInsets.all(4),
          //       //     labelColor: ColorResources.COLOR_WHITE,
          //       //     unselectedLabelColor: ColorResources.COLOR_BLACK,
          //       //     splashBorderRadius: BorderRadius.circular(50),
          //       //     indicator: BoxDecoration(
          //       //         borderRadius: BorderRadius.circular(50), // Creates border
          //       //         color: ColorResources
          //       //             .COLOR_PPIMARY), //Change background color from here
          //       //     tabs: [
          //       //       Padding(
          //       //         padding: const EdgeInsets.symmetric(vertical: 9),
          //       //         child: Text('Videolar'),
          //       //       ),
          //       //       Padding(
          //       //         padding: const EdgeInsets.symmetric(vertical: 9),
          //       //         child: Text('Musiqalar'),
          //       //       ),
          //       //     ],
          //       //   ),
          //       // ),
          //       // TabBarView(
          //       //   children: [
          //       //     Icon(Icons.directions_transit, size: 350),
          //       //     Icon(Icons.directions_car, size: 350),
          //       //   ],
          //       // ),
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
