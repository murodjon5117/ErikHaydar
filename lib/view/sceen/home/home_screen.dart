import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/sceen/home/home_categories.dart';
import 'package:erik_haydar/view/sceen/home/slider_2.dart';
import 'package:erik_haydar/view/sceen/home/slider_screen.dart';
import 'package:erik_haydar/view/sceen/home/user_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).getSliderData();
    Provider.of<HomeProvider>(context, listen: false).getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      key: drawerGlobalKey,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (p0, p1) => Consumer<HomeProvider>(
            builder: (context, value, child) => AbsorbPointer(
              absorbing: value.isLoading,
              child: RefreshIndicator(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: p1.maxHeight,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        UserData().padding('Salom', "Fakhriyor"),
                        const SliderScreen(),
                        const SizedBox(height: 35,),
                        Container(
                          decoration: const BoxDecoration(
                            color: ColorResources.COLOR_WHITE,
                            boxShadow: [
                              const BoxShadow(
                                color: ColorResources.COLOR_EBE9E9,
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                              )
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(24),
                                topLeft: Radius.circular(24)),
                          ),
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: value.homeDataList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return HomeCategoriesScreen(
                                films: value.homeDataList[index],
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onRefresh: () async {
                  value.getHomeData();
                  value.getSliderData();
                },
              ),
            ),
          ),
        ),
      ),
      // body: LayoutBuilder(
      //   builder: (p0, p1) => Consumer<HomeProvider>(
      //     builder: (context, value, child) => ConstrainedBox(
      //       constraints: BoxConstraints(
      //         minHeight: p1.maxHeight,
      //         minWidth: p1.maxWidth,
      //       ),
      //       child: Column(children: [
      //         UserData().padding('Salom', "Fakhriyor"),
      //         const SliderScreen(),
      //         const HomeCategoriesScreen(),
      //       ]),
      //     ),
      //   ),
      // ),
    );
  }

  CustomScrollView _scrollView(
      ScrollController scrollController, BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      slivers: [
        SliverToBoxAdapter(
            child: Consumer<HomeProvider>(
          builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserData().padding('Salom', "Fakhriyor"),
                const SliderScreen(),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return HomeCategoriesScreen(
                        films: value.homeDataList[index],
                      );
                    },
                  ),
                )
              ]),
        )),
        // Consumer<HomeProvider>(
        //   builder: (context, value, child) => SliverToBoxAdapter(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         UserData().padding('Salom', "Fakhriyor"),
        //         const SliderScreen(),
        //         Expanded(
        //           child: ListView.builder(
        //             shrinkWrap: true,
        //             scrollDirection: Axis.vertical,
        //             itemBuilder: (context, index) {
        //               return HomeCategoriesScreen(
        //                 films: value.homeDataList[index],
        //               );
        //             },
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
