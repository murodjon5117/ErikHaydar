import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/view/sceen/home/music/music_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';
import '../../../provider/favorite_provider.dart';

class FavoriteMusic extends StatefulWidget {
  @override
  State<FavoriteMusic> createState() => _FavoriteMusicState();
}

class _FavoriteMusicState extends State<FavoriteMusic> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteProvider>(context, listen: false)
          .getFavoriteMusics( false);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
        builder: (context, value, child) =>  Stack(
                children: [
                  NotificationListener(
                    onNotification: _scrollNotification,
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, bottom: 8),
                        child: list(context, value)),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: value.isPagingLoading
                          ? const LinearProgressIndicator(
                              backgroundColor: ColorResources.COLOR_GREY,
                              color: ColorResources.COLOR_PPIMARY,
                              minHeight: 4,
                            )
                          : const SizedBox())
                ],
              ));
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<FavoriteProvider>(context, listen: false).isPaging()) {
      Provider.of<FavoriteProvider>(context, listen: false)
          .getFavoriteMusics(true);
    }
    return true;
  }

  Widget list(BuildContext context, FavoriteProvider value) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: value.musics.length,
      itemBuilder: (context, index) {
        return MusicItem(musicModel: value.musics[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12,
        );
      },
    );
  }
}
