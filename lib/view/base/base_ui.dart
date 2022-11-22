import 'package:cached_network_image/cached_network_image.dart';
import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/main.dart';
import 'package:erik_haydar/util/dimensions.dart';
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
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(Images.back_icon),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  

  Widget imageNetwork(String? url) {
    return CachedNetworkImage(
      imageUrl: url??'',
      fit: BoxFit.contain,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
      placeholder: (context, url) => Image.asset(
        Images.placeholderImage,
      ),
      errorWidget: (context, url, error) => Image.asset(
        Images.placeholderImage,
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

  Widget buttonsType(
    TypeButton typeButton,
    BuildContext context,
    VoidCallback? onTap,
    String text,
  ) {
    final ButtonStyle yellowStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_PPIMARY,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.zero,
      elevation: 0.0,
    );
    final ButtonStyle cancelStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_F7F7F9,
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
    final ButtonStyle settingsStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_WHITE,
      minimumSize: Size(MediaQuery.of(context).size.width, 48),
      padding: EdgeInsets.zero,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          width: 2.0,
          color: ColorResources.COLOR_EBE9E9,
        ),
      ),
    );

    final ButtonStyle tarifStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_PPIMARY,
      minimumSize: Size(MediaQuery.of(context).size.width, 31),
      padding: EdgeInsets.zero,
      elevation: 0.0,
    );
    final ButtonStyle tarifBorderStyle = TextButton.styleFrom(
      backgroundColor: ColorResources.COLOR_WHITE,
      minimumSize: Size(MediaQuery.of(context).size.width, 31),
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
      case TypeButton.filledIcon:
        return ElevatedButton(
            style: yellowStyle,
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.wallet),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  style: filledButtonTextStyle,
                ),
              ],
            ));
      case TypeButton.settings:
        return ElevatedButton(
            style: settingsStyle,
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(Images.settings),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(text,
                        style: textButtonTextStyle.copyWith(
                            color: ColorResources.COLOR_BLACK)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(Images.right),
                ),
              ],
            ));
      case TypeButton.downloaded:
        return ElevatedButton(
            style: settingsStyle,
            onPressed: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(Images.download),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(text,
                        style: textButtonTextStyle.copyWith(
                            color: ColorResources.COLOR_BLACK)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SvgPicture.asset(Images.right),
                ),
              ],
            ));
      case TypeButton.tarif:
        return ElevatedButton(
            style: tarifStyle,
            onPressed: onTap,
            child: Text(
              text,
              style: filledButtonTextStyle.copyWith(
                  fontSize: Dimensions.FONT_SIZE_12),
            ));
      case TypeButton.tarifBorder:
        return ElevatedButton(
            style: tarifBorderStyle,
            onPressed: onTap,
            child: Text(text,
                style: textButtonTextStyle.copyWith(
                    color: ColorResources.COLOR_BLACK,
                    fontSize: Dimensions.FONT_SIZE_12)));
      case TypeButton.cancel:
        return ElevatedButton(
            style: cancelStyle,
            onPressed: onTap,
            child: Text(
              text,
              style: textButtonTextStyle.copyWith(
                  color: ColorResources.COLOR_BLACK),
            ));
    }
  }
}
