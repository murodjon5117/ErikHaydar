import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';

import 'anim_video_controller.dart';
import 'settings/video_settings.dart';

class AnimVideoPlayer extends StatefulWidget {
  final VideoSettings settings;

  AnimVideoPlayer({Key? key, required this.settings}) : super(key: key);

  @override
  _AnimVideoPlayerState createState() => _AnimVideoPlayerState();
}

class _AnimVideoPlayerState extends State<AnimVideoPlayer> {
  late ChewieController chewieController;
  late VideoQuality videoQuality;
  late Duration playback;

  ChewieController _buildChewieController() {
    return ChewieController(
      videoPlayerController: videoQuality.videoController,
      autoPlay: widget.settings.autoPlay,
      autoInitialize: true,
      customControls: AnimVideoControls(
        videoSettings: widget.settings,
        changeQuality: doChangeQuality,
      ),
      startAt: playback,
    );
  }

  @override
  void initState() {
    super.initState();
    videoQuality = widget.settings.defaultQuality;
    playback = const Duration();
    chewieController = _buildChewieController();
  }

  Future<void> doChangeQuality(String quality) async {
    final video = widget.settings.setVideoQuality(quality);
    playback = (await chewieController.videoPlayerController.position)!;

    if (video.quality != videoQuality.quality) {
      chewieController.pause();

      setState(() {
        videoQuality = video;
        chewieController.dispose();
        chewieController = _buildChewieController();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Chewie(
        controller: chewieController,
      ),
    );
  }

  @override
  void dispose() {
    widget.settings.qualities?.forEach((element) {
      element.videoController.dispose();
    });
    chewieController.dispose();
    super.dispose();
  }
}
