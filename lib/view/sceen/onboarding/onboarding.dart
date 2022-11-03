import 'dart:developer';

import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/sceen/auth/login/login_screen.dart';
import 'package:erik_haydar/view/sceen/dashboard/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'intro_screen.dart';
import 'intro_screens.dart';

class onBoardingPage extends StatefulWidget {
  const onBoardingPage({Key? key}) : super(key: key);

  @override
  onBoardingPageState createState() => onBoardingPageState();
}

class onBoardingPageState extends State<onBoardingPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var screens = IntroScreens(
      onDone: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      ),
      // onSkip: () => print('Skipping the intro slides'),
      footerBgColor: const Color.fromARGB(255, 222, 219, 217).withOpacity(.8),
      // backFooterColor: const Color(0xFFCC4242),
      activeDotColor: const Color(0xFFCC4242),
      footerRadius: 24.0,
//      indicatorType: IndicatorType.CIRCLE,
      slides: [
        IntroScreen(
          title: 'Erik Haydar',
          imageAsset: Images.erik1,
          description:
              'Bitta uraman qayering og\'riyotganini bilmay o\'tib ketasan',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'Erik Haydar',
          imageAsset: Images.erik2,
          description:
              'Bitta uraman qayering og\'riyotganini bilmay o\'tib ketasan',
          headerBgColor: Colors.white,
        ),
        IntroScreen(
          title: 'Erik Haydar',
          imageAsset: Images.erik3,
          description:
              'Bitta uraman qayering og\'riyotganini bilmay o\'tib ketasan',
          headerBgColor: Colors.white,
        ),
      ],
    );

    return Scaffold(
      body: screens,
    );
  }
}
