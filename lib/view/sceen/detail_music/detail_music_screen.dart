import 'package:erik_haydar/data/model/response/body/detail_music_model.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/detail_film/comment_list.dart';
import 'package:erik_haydar/view/sceen/detail_film/set_comment.dart';
import 'package:erik_haydar/view/sceen/detail_music/player/music_payer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/detail_music_provider.dart';
import '../../../provider/home_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class DetailMusicScreen extends StatefulWidget {
  final String slug;
  final String image;

  const DetailMusicScreen({super.key, required this.slug, required this.image});
  @override
  State<DetailMusicScreen> createState() => _DetailMusicScreenState();
}

class _DetailMusicScreenState extends State<DetailMusicScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<MusicDetailProvider>(context, listen: false)
          .getMusicDetail(widget.slug);
      Provider.of<MusicDetailProvider>(context, listen: false)
          .getComment(widget.slug, false);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Consumer<MusicDetailProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: ColorResources.COLOR_WHITE,
          appBar: AppBar(
            backgroundColor: ColorResources.COLOR_WHITE,
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
              icon: SvgPicture.asset(Images.back_icon),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [favorite(context, value.detailMusicModel)],
          ),
          body: Stack(
            children: [
              NotificationListener(
                onNotification: _scrollNotification,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: p1.maxHeight,
                    ),
                    child: Column(
                      children: [
                        detaiPhoto(value.detailMusicModel.image ?? '',
                            value.detailMusicModel.isFree ?? false),
                        detailInformation(value.detailMusicModel),
                        MusicPayer(slug: widget.slug),
                        detailFunctions(value.detailMusicModel.viewsCount ?? 0),
                        CommentList(
                          commentList: value.commentList,
                          totalCount: value.totalItemCount,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SetComment(id: value.detailMusicModel.id ?? 0)
            ],
          ),
        ),
      ),
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<MusicDetailProvider>(context, listen: false).isPaging()) {
      Provider.of<MusicDetailProvider>(context, listen: false)
          .getComment(widget.slug, true);
    }
    return true;
  }

  Widget detailInformation(DetailMusicMidel detailMusicModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated('downloaded', context),
                style:
                    titleTextField.copyWith(color: ColorResources.COLOR_BBB5B5),
              ),
              Text(
                detailMusicModel.createdAt ?? '',
                style: titleTextField,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            detailMusicModel.musicAuthor ?? '',
            style: filledButtonTextStyle.copyWith(
                fontSize: Dimensions.FONT_SIZE_14,
                color: ColorResources.COLOR_BLACK),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            detailMusicModel.name ?? '',
            style: detailTitle,
          ),
        ],
      ),
    );
  }

  Widget detailFunctions(int viewCount) {
    return Consumer<MusicDetailProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                value.likeForFilm(widget.slug);
              },
              child: Column(
                children: [
                  SvgPicture.asset(value.isLike ? Images.liked : Images.unLike),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    value.likeCount.toString(),
                    style: titleTextField.copyWith(
                        color: value.isLike
                            ? ColorResources.COLOR_PPIMARY
                            : ColorResources.COLOR_737373),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            GestureDetector(
              onTap: () {
                value.dissLikeForFilm(widget.slug);
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                      value.isDisLike ? Images.disliked : Images.unDislike),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    value.likeDisCount.toString(),
                    style: titleTextField.copyWith(
                        color: value.isDisLike
                            ? ColorResources.COLOR_PPIMARY
                            : ColorResources.COLOR_737373),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              children: [
                SvgPicture.asset(Images.view),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  viewCount.toString(),
                  style: titleTextField,
                ),
              ],
            ),
            const Spacer(),
            // Column(
            //   children: [
            //     SvgPicture.asset(Images.downloadVideo),
            //     const SizedBox(
            //       height: 4,
            //     ),
            //     Text(
            //       getTranslated('download', context),
            //       style: downloadTextStyle,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget detaiPhoto(String imageUrl, bool isFree) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
              width: double.infinity,
              height: 355,
              child: BaseUI().imageNetwork(widget.image)),
        ),
        Positioned(top: 10, left: 0, child: tipVideo(isFree, context)),
      ],
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
        padding: const EdgeInsets.fromLTRB(25, 5, 27, 5),
        child: Text(getTranslated(isFree ? 'free' : 'premium', context),
            style: itemWidgetTextStyle.copyWith(
                color: ColorResources.COLOR_WHITE)),
      ),
    );
  }

  Widget favorite(
    BuildContext context,
    DetailMusicMidel detailFilmModel,
  ) {
    return GestureDetector(
        onTap: () {
          Provider.of<HomeProvider>(context, listen: false)
              .addFavorite(widget.slug)
              .then((value) {
            if (value.status == 200) {
              if (detailFilmModel.isUserFavoriteFilm == true) {
                setState(() {
                  detailFilmModel.isUserFavoriteFilm = false;
                });
              } else {
                setState(() {
                  detailFilmModel.isUserFavoriteFilm = true;
                });
              }
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SvgPicture.asset(detailFilmModel.isUserFavoriteFilm ?? false
              ? Images.favorited
              : Images.favorite),
        ));
  }
}
