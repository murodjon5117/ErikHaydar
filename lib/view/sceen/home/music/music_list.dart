import 'package:flutter/cupertino.dart';

import '../../../../data/model/response/body/music_model.dart';
import 'music_item.dart';

class HomeMusicList extends StatelessWidget {
  final List<MusicModel> list;
  double setPadding(int index) {
    if (index == 0) {
      return 20;
    } else {
      return 0;
    }
  }

  const HomeMusicList({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 131,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.only(top: 12, bottom: 12, left: setPadding(index)),
            child: MusicItem(musicModel: list[index]),
          );
        }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 12,); },
      ),
    );
  }
}
