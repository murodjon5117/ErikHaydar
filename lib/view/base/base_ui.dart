import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../util/color_resources.dart';
import '../../util/images.dart';
import '../../util/styles.dart';

class BaseUI {
  appBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorResources.COLOR_WHITE,
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        alignment: Alignment.center,
        icon: SvgPicture.asset(Images.back_icon),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
  Widget progressIndicator() {
    return Center(
      child: SizedBox(
          height: 100,
          width: 150,
          child: Lottie.asset('assets/json/animation_loading.json')),
    );
  }

  Widget buttonsType( TypeButton typeButton, BuildContext context,
      VoidCallback? onTap, String text) {
    final ButtonStyle yellowStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_PPIMARY,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.zero,
      elevation: 0.0,
    );
    final ButtonStyle textStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_WHITE,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.zero,
      elevation: 0.0,
    );
    final ButtonStyle borderStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_WHITE,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.zero,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 2.0,
          color: ColorResources.COLOR_RED,
        ),
      ),
    );

    switch (typeButton) {
      case TypeButton.filled:
        return ElevatedButton(
            style: yellowStyle,
            onPressed: onTap,
            child: Text(
              text,
              style: filledButtonTextStyle,
            ));
      case TypeButton.text:
        return ElevatedButton(
            style: textStyle,
            onPressed: onTap,
            child: Text(text, style: textButtonTextStyle));
      case TypeButton.border:
        return ElevatedButton(
            style: borderStyle,
            onPressed: onTap,
            child: Text(text, style: textButtonTextStyle));
    }
  }
}
