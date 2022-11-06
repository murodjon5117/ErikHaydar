import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/sceen/category/category_screen.dart';
import 'package:erik_haydar/view/sceen/home/video_player/media_player.dart';
import 'package:erik_haydar/view/sceen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

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
      HomeScreen(),
      CategoryScreen(),
      MediaPlayer(),
      ProfileScreen(),
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
      ),
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
    )
        // PersistentTabView.custom(
        //   context,
        //   controller: _controller,
        //   screens: _buildScreens(),
        //   confineInSafeArea: true,
        //   itemCount: 4,
        //   stateManagement: false,
        //   hideNavigationBar: false,
        //   customWidget: (p0) {
        //     return CustomNavBarWidget(
        //       items: _navBarsItems(),
        //       onItemSelected: (index) {
        //         setState(() {
        //           _controller!.index = index;
        //         });
        //       },
        //       selectedIndex: _controller!.index,
        //       context: context,
        //     );
        //   },

        // ),
        );
  }
}

class CustomNavBarWidget extends StatefulWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  BuildContext context;

  CustomNavBarWidget(
      {Key? key,
      required this.selectedIndex,
      required this.items,
      required this.onItemSelected,
      required this.context});

  @override
  State<CustomNavBarWidget> createState() => _CustomNavBarWidgetState();
}

class _CustomNavBarWidgetState extends State<CustomNavBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, int index) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child:
                        isSelected ? item.icon : item.inactiveIcon ?? item.icon,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title!,
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorResources.COLOR_GRAY,
      child: SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.items.map((item) {
            int index = widget.items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  widget.onItemSelected(index);
                },
                child: _buildItem(item, widget.selectedIndex == index, index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
