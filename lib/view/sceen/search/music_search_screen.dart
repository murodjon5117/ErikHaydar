import 'package:erik_haydar/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/music/music_item.dart';

class MusicSearchScreen extends StatefulWidget {
  final String query;

  const MusicSearchScreen({super.key, required this.query});
  @override
  State<MusicSearchScreen> createState() => _MusicSearchScreenState();
}

class _MusicSearchScreenState extends State<MusicSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
        builder: (context, value, child) => NotificationListener(
          onNotification: _scrollNotification,
          child: Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: list(context, value)),
        ));
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<SearchProvider>(context, listen: false).isPagingMusic()) {
      Provider.of<SearchProvider>(context, listen: false)
          .getMusicSearch(widget.query, true);
    }
    return true;
  }

  Widget list(BuildContext context, SearchProvider value) {
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
