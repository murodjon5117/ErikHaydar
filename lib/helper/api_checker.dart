import 'package:flutter/material.dart';
import '../data/model/response/base/api_response.dart';

class ApiChecker {
  const ApiChecker();
  static Future<void> checkApi(
      BuildContext context, ApiResponse apiResponse) async {
    if (apiResponse.error == 'Unauthorized') {
      // Provider.of<ProfileProvider>(context, listen: false).deleteToken();
    }

    showDialog(
      context: context,
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
  }

  static Future<void> checkApiForRegister(
      BuildContext context, String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xatolik"),
          content: Text(message),
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
  }
}
