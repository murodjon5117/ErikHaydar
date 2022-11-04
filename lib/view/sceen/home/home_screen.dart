import 'package:erik_haydar/provider/home_provider/home_provider.dart';
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
    Provider.of<HomeProvider>(context, listen: false).getSliderData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerGlobalKey,
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, value, child) => AbsorbPointer(
            absorbing: value.isLoading,
            child: RefreshIndicator(
              child: Stack(
                children: [
                  _scrollView(_scrollController, context),
                ],
              ),
              onRefresh: () async {
                setState(() {});
              },
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserData().padding('Salom', "Fakhriyor"),
              const SliderScreen(),
              // const HomeCategoriesScreen(),
              // const HomeCategoriesScreen(),
              // const HomeCategoriesScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
