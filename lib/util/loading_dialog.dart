import 'package:erik_haydar/main.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';

class LoadingOverlay {
  void hide() {
    Navigator.of(MyApp.navigatorKey.currentState!.context).pop();
  }

  void show() {
    showDialog(
        context: MyApp.navigatorKey.currentState!.context,
        barrierDismissible: false,
        barrierColor: ColorResources.COLOR_BLACK.withOpacity(0.1),
        builder: (ctx) => _FullScreenLoader());
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: BaseUI().progressIndicator());
  }
}
