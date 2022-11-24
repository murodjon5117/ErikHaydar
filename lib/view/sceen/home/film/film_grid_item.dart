import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/detail_film/detail_film_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../provider/home_provider.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class FilmGridItem extends StatefulWidget {
  final Films item;
  const FilmGridItem({super.key, required this.item});

  @override
  State<FilmGridItem> createState() => _FilmGridItemState();
}

class _FilmGridItemState extends State<FilmGridItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            withNavBar: false,
            screen: DetailFilmScreen(slug: widget.item.slug ?? '',image: widget.item.image??'',));
      },
      child: Container(
        height: 201,
        width: 162,
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
                  right: 12,
                  left: 12,
                  child: SizedBox(
                    height: 100,
                    width: 130,
                    child: BaseUI().imageNetwork(widget.item.image ?? ''),
                  ),
                ),
                Positioned(left: 8, top: 8, child: favorite(context)),
                Positioned(
                    left: 0,
                    top: 81,
                    child: tipVideo(widget.item.isFree ?? false, context)),
                Positioned(
                    bottom: 0,
                    left: 12,
                    right: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.item.name} \n',
                          style: titleTextField.copyWith(
                              color: ColorResources.COLOR_BLACK),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        Row(
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
                                    widget.item.viewsCount.toString(),
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
                                    widget.item.activeCommentsCount.toString(),
                                    style: itemWidgetTextStyle,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 9,
                        )
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
              .addFavorite(widget.item.slug ?? '')
              .then((value) {
            if (value.status == 200) {
              if (widget.item.isUserFavoriteFilm == true) {
                setState(() {
                  widget.item.isUserFavoriteFilm = false;
                });
              } else {
                setState(() {
                  widget.item.isUserFavoriteFilm = true;
                });
              }
            }
          });
        },
        child: SvgPicture.asset(widget.item.isUserFavoriteFilm ?? false
            ? Images.favorited
            : Images.favorite));
  }
}
