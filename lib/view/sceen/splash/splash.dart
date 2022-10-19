import 'package:erik_haydar/view/sceen/auth/login/login_screen.dart';
import 'package:erik_haydar/view/sceen/auth/register/full_register_screen.dart';
import 'package:erik_haydar/view/sceen/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

import '../../../util/color_resources.dart';

class SplashScreen extends StatefulWidget{
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
        Future.delayed(const Duration(milliseconds: 2000), () {
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return FullRegisterScreen();
            },
          ),
          (_) => false,
        );
        });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ColorResources.COLOR_PPIMARY,
                )),
    );
  }
}