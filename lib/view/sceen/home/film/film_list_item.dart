import 'package:erik_haydar/data/model/response/body/home_model.dart';
import 'package:erik_haydar/data/model/response/body/music_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../detail_film/detail_film_screen.dart';

class FilmListItem extends StatefulWidget {
  final Films item;
  // final int index;

  const FilmListItem({super.key, required this.item});

  @override
  State<FilmListItem> createState() => _FilmListItemState();
}

class _FilmListItemState extends State<FilmListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            withNavBar: false,
            screen: DetailFilmScreen(slug: widget.item.slug ?? ''));
      },
      child: Consumer<CategoryProvider>(
        builder: (context, value, child) => Container(
          height: 122,
          width: double.infinity,
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
                      height: 98,
                      width: 138,
                      child: BaseUI().imageNetwork(widget.item.image ?? ''),
                    ),
                  ),
                  Positioned(
                      left: 8,
                      top: 8,
                      child: favorite(
                        context,
                      )),
                  Positioned(
                      left: 0,
                      top: 71,
                      child: tipVideo(widget.item.isFree ?? false, context)),
                  Positioned(
                      left: 162,
                      top: 12,
                      right: 12,
                      bottom: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.item.name}',
                            style: titleTextField.copyWith(
                                color: ColorResources.COLOR_BLACK),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 12,
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
                                            widget.item.activeCommentsCount
                                                .toString(),
                                            style: itemWidgetTextStyle,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                ],
              )
            ],
          ),
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
