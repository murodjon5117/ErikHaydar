import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/model/response/body/slider_model/slider_model.dart';
import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class FilmItem extends StatelessWidget {
  final Films item;
  const FilmItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 201,
      width: 162,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              color: ColorResources.COLOR_EBE9E9,
              blurRadius: 3.0,
              spreadRadius: 1.0,
            )
          ],
          color: ColorResources.COLOR_WHITE,
          borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Stack(
            children: [
              Positioned(
                top: 12,
                right: 12,
                left: 12,
                child: SizedBox(
                  height: 100,
                  width: 130,
                  child: BaseUI().imageNetwork(item.image ?? ''),
                ),
              ),
              Positioned(
                  left: 8, top: 8, child: SvgPicture.asset(Images.unliked)),
              Positioned(left: 0, top: 81, child: tipVideo()),
            ],
          )
        ],
      ),
    );
  }

  Widget tipVideo() {
    return Container(
      decoration: BoxDecoration(
          color: ColorResources.COLOR_6212C7,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 3, 10, 3),
        child: Text('Premium',
            style: itemWidgetTextStyle.copyWith(
                color: ColorResources.COLOR_WHITE)),
      ),
    );
  }
}
