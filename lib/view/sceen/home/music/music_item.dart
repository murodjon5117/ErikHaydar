import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../provider/home_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../detail_music/detail_music_screen.dart';

class MusicItem extends StatefulWidget {
  final MusicModel musicModel;
  const MusicItem({super.key, required this.musicModel});

  @override
  State<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends State<MusicItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            withNavBar: false,
            screen: DetailMusicScreen(
              image: widget.musicModel.image ?? '',
              slug: widget.musicModel.slug ?? '',
            ));
      },
      child: Container(
        height: 119,
        width: 335,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: ColorResources.COLOR_BLACK.withOpacity(0.08),
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
                    child: BaseUI().imageNetwork(widget.musicModel.image ?? ''),
                  ),
                ),
                Positioned(left: 8, top: 8, child: favorite(context)),
                Positioned(
                    left: 0,
                    top: 71,
                    child:
                        tipVideo(widget.musicModel.isFree ?? false, context)),
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
                          '${widget.musicModel.name}',
                          style: titleTextField.copyWith(
                              color: ColorResources.COLOR_BLACK),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.musicModel.musicAuthor} \n',
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
                                          widget.musicModel.viewsCount
                                              .toString(),
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
                                          widget.musicModel.activeCommentsCount
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

  Widget favorite(
    BuildContext context,
  ) {
    return GestureDetector(
        onTap: () {
          Provider.of<HomeProvider>(context, listen: false)
              .addFavorite(widget.musicModel.slug ?? '')
              .then((value) {
            if (value.status == 200) {
              if (widget.musicModel.isUserFavoriteFilm == true) {
                setState(() {
                  widget.musicModel.isUserFavoriteFilm = false;
                });
              } else {
                setState(() {
                  widget.musicModel.isUserFavoriteFilm = true;
                });
              }
            }
          });
        },
        child: SvgPicture.asset(widget.musicModel.isUserFavoriteFilm ?? false
            ? Images.favorited
            : Images.favorite));
  }
}
