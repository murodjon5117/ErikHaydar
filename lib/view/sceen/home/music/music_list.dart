import 'package:flutter/cupertino.dart';

import '../../../../data/model/response/body/music_model.dart';
import 'music_item.dart';

class HomeMusicList extends StatelessWidget {
  final List<MusicModel> list;

  const HomeMusicList({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 131,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return MusicItem(musicModel: list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 12,
          );
        },
      ),
    );
  }
}
