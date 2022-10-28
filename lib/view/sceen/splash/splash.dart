import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/auth/login/login_screen.dart';
import 'package:erik_haydar/view/sceen/auth/register/register_screen.dart';
import 'package:erik_haydar/view/sceen/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (BuildContext context) {
            return const onBoardingPage();
          },
        ),
        (_) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseUI().progressIndicator(),
    );
  }
}
