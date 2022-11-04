import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class MusicItem extends StatelessWidget {
  final MusicModel musicModel;
  const MusicItem({super.key, required this.musicModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 119,
      width: 335,
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
                bottom: 12,
                left: 12,
                child: SizedBox(
                  height: 83,
                  width: 99,
                  child: BaseUI().imageNetwork(musicModel.image ?? ''),
                ),
              ),
              Positioned(
                  left: 8, top: 8, child: SvgPicture.asset(Images.unliked)),
              Positioned(
                  left: 0,
                  top: 71,
                  child: tipVideo(musicModel.isFree ?? false, context)),
              Positioned(
                  left: 127,
                  top: 12,
                  right: 12,
                  bottom: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${musicModel.name}',
                        style: titleTextField.copyWith(
                            color: ColorResources.COLOR_BLACK),
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${musicModel.musicAuthor} \n',
                        style: itemWidgetTextStyle.copyWith(
                            color: ColorResources.COLOR_BBB5B5),
                        maxLines: 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.eyeIcon),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        musicModel.viewsCount.toString(),
                                        style: itemWidgetTextStyle,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(Images.commentIcon),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        musicModel.activeCommentsCount
                                            .toString(),
                                        style: itemWidgetTextStyle,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [SvgPicture.asset(Images.playRed)],
                          ))
                        ],
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget tipVideo(bool isFree, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isFree
              ? ColorResources.COLOR_0ABA66
              : ColorResources.COLOR_6212C7,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 3, 10, 3),
        child: Text(getTranslated(isFree ? 'free' : 'premium', context),
            style: itemWidgetTextStyle.copyWith(
                color: ColorResources.COLOR_WHITE)),
      ),
    );
  }
}
