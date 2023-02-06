import 'package:erik_haydar/provider/favorite_provider.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/sceen/category/category_screen.dart';
import 'package:erik_haydar/view/sceen/favorite/favorites_screen.dart';
import 'package:erik_haydar/view/sceen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../home/home_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PersistentTabController? _controller;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const CategoryScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        inactiveIcon: SvgPicture.asset(
          Images.home_icon,
        ),
        title: 'Asosiy',
        textStyle: itemWidgetTextStyle,
        icon: SvgPicture.asset(Images.activeHome,
            color: ColorResources.COLOR_PPIMARY),
        activeColorPrimary: ColorResources.COLOR_PPIMARY,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.activeCategory,
          color: ColorResources.COLOR_PPIMARY,
        ),
        inactiveIcon: SvgPicture.asset(
          Images.inactiveCategory,
        ),
        title: 'Kategoriya',
        activeColorPrimary: ColorResources.COLOR_PPIMARY,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.activeFavorite,
          color: ColorResources.COLOR_PPIMARY,
        ),
        inactiveIcon: SvgPicture.asset(
          Images.inactiveFavorite,
        ),
        title: 'Saqlanganlar',
        activeColorPrimary: ColorResources.COLOR_PPIMARY,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Images.activeProfile,
          color: ColorResources.COLOR_PPIMARY,
        ),
        inactiveIcon: SvgPicture.asset(
          Images.inactiveProfile,
        ),
        title: 'Profil',
        activeColorPrimary: ColorResources.COLOR_PPIMARY,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      onItemSelected: (value) {
        if (value == 2) {
          Provider.of<FavoriteProvider>(context, listen: false)
              .getFavoriteFilms(false);
          Provider.of<FavoriteProvider>(context, listen: false)
              .getFavoriteMusics(false);
        }
      },
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    ));
  }
}
