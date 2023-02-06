import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

import 'package:flutter/foundation.dart';

import '../../../data/model/response/base/video/m3u8.dart';

class PlayerScreen extends StatefulWidget {
  final List<M3U8pass> yoyo;

  const PlayerScreen({super.key, required this.yoyo});
  @override
  State<PlayerScreen> createState() => _PlayVideoFromAssetState();
}

class _PlayVideoFromAssetState extends State<PlayerScreen> {
  late final PodPlayerController controller;
  List<VideoQalityUrls> qualityList = [];
  @override
  void initState() {
    for (var element in widget.yoyo) {
      int indexStart = element.dataQuality!.indexOf('x') + 1;
      int indexEnd = element.dataQuality!.length;
      qualityList.add(VideoQalityUrls(
        quality:
            int.parse(element.dataQuality!.substring(indexStart, indexEnd)),
        url: element.dataURL ?? '',
      ));
    }
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: qualityList),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseUI().appBarMusic(context),
      backgroundColor: ColorResources.COLOR_BLACK,
      body: SafeArea(
        child: Center(
          child: PodVideoPlayer(
            onLoading: (context) => BaseUI().progressIndicator(),
            backgroundColor: ColorResources.COLOR_BLACK,
            controller: controller,
            podPlayerLabels: PodPlayerLabels(
              loopVideo: getTranslated('loop', context),
              optionDisabled: getTranslated('off', context),
              optionEnabled: getTranslated('on', context),
              settings: getTranslated('options', context),
              quality: getTranslated('quality', context),
              playbackSpeed: getTranslated('speed', context)
            ),
            podProgressBarConfig: const PodProgressBarConfig(
              padding: kIsWeb
                  ? EdgeInsets.zero
                  : EdgeInsets.only(
                      bottom: 20,
                      left: 20,
                      right: 20,
                    ),
              playingBarColor: ColorResources.COLOR_PPIMARY,
              circleHandlerColor: ColorResources.COLOR_PPIMARY,
              backgroundColor: Colors.blueGrey,
            ),
          ),
        ),
      ),
    );
  }
}
