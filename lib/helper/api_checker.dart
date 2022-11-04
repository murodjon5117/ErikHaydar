import 'package:erik_haydar/main.dart';
import 'package:flutter/material.dart';

import '../data/model/response/base/api_response.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    if (apiResponse.error == 'Unauthorized') {
      // Provider.of<ProfileProvider>(context, listen: false).deleteToken();
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
