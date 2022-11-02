import 'package:erik_haydar/data/model/response/body/user_info_model.dart';
import 'package:erik_haydar/helper/shared_pres.dart';
import 'package:erik_haydar/util/app_constants.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Text(SharedPref().read(AppConstants.USER_DATA).toString()),
          // UserInfoData user = UserInfoData.fromJson(await sharedPref.read("user"));
        ],
      ),
    );
  }
}
