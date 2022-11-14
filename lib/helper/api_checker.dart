import 'package:erik_haydar/main.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/model/response/base/api_response.dart';
import '../view/sceen/auth/login/login_screen.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    if (apiResponse.error == 'Unauthorized') {
      Provider.of<UserDataProvider>(MyApp.navigatorKey.currentContext!,
              listen: false)
          .deleteUserData();
      Navigator.of(MyApp.navigatorKey.currentContext!, rootNavigator: true)
          .pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const LoginScreen();
          },
        ),
        (_) => false,
      );
    }
    showDialog(
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xatolik"),
          content: Text(apiResponse.response?.data['message'] ??
              apiResponse.error.toString()),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    // OneContext()
    //     .showDialog(
    //         builder: (_) => AlertDialog(
    //               content: Text(apiResponse.response?.data['message'] ??
    //                   apiResponse.error.toString()),
    //               actions: [
    //                 ElevatedButton(
    //                     style: ButtonStyle(
    //                         backgroundColor:
    //                             MaterialStateProperty.all(Colors.blue)),
    //                     child: Text('Close'),
    //                     onPressed: () {
    //                       OneContext().popDialog("Nice!");
    //                     })
    //               ],
    //             ))
    //     .then((result) => print(result));
  }
}
