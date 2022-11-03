import 'package:bottom_bar/bottom_bar.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/sceen/home/home_screen.dart';
import 'package:erik_haydar/view/sceen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/color_resources.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: PageView(
        allowImplicitScrolling: false,
        controller: _pageController,
        children: [
          HomeScreen(),
          Container(color: Colors.red),
          Container(color: Colors.greenAccent.shade700),
          ProfileScreen(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
          child: SafeArea(
            child: BottomBar(
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              selectedIndex: _currentPage,
              onTap: (int index) {
                _pageController.jumpToPage(index);
                setState(() => _currentPage = index);
              },
              items: <BottomBarItem>[
                BottomBarItem(
                    activeIconColor: Colors.white,
                    icon: SvgPicture.asset(Images.home_icon),
                    title: const Text('Asosiy'),
                    activeTitleColor: Colors.white70,
                    activeColor: ColorResources.BOTTOM_COLOR,
                    backgroundColorOpacity: 1),
                BottomBarItem(
                    activeIconColor: Colors.white,
                    icon: SvgPicture.asset(Images.play_icon),
                    title: Text('Play'),
                    activeTitleColor: Colors.white70,
                    activeColor: ColorResources.BOTTOM_COLOR,
                    backgroundColorOpacity: 1),
                BottomBarItem(
                    activeIconColor: Colors.white,
                    icon: SvgPicture.asset(Images.heart_icon),
                    title: const Text('Yoqtirgan'),
                    activeTitleColor: Colors.white70,
                    activeColor: ColorResources.BOTTOM_COLOR,
                    backgroundColorOpacity: 1),
                BottomBarItem(
                    activeIconColor: Colors.white,
                    icon: SvgPicture.asset(Images.person_icon),
                    title: const Text('Odamlar'),
                    activeTitleColor: Colors.white70,
                    activeColor: ColorResources.BOTTOM_COLOR,
                    backgroundColorOpacity: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
