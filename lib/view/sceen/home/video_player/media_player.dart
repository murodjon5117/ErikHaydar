import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_player/video_player.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key});

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> with WidgetsBindingObserver {
  // late VideoPlayerController _controller;
  // ChewieController? _chewieController;
  var isloaded = false;
  bool showOverLay = false;
  bool isFullScreen = false;
  int _currentPosition = 0;
  int _duration = 0;
  bool isBuffering = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      setState(() {
        // _controller.pause();
        controller.pause();
      });
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver;
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]);
  //   _controller = VideoPlayerController.network(
  //       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
  //       'https://hamshira.biznesgoya.uz/uploads/media/stream/1/6f9e961dc1b1ea58daf6469956ae7a48/4474efb04d27d874331982f1a8b77c2c.m3u8');
  //   _attachListenerToController();
  //   _controller.setLooping(true);

  //   _controller.initialize().then((_) => setState(() {
  //         //isloaded = true;
  //         _chewieController = ChewieController(
  //           videoPlayerController: _controller,
  //           allowFullScreen: true,
  //           allowMuting: true,
  //           autoPlay: true,
  //           looping: true,
  //           zoomAndPan: true,
  //           autoInitialize: true,
  //         );
  //       }));
  //   _chewieController?.play();
  // }

  bool isMusicOn = true;
  void soundToggle() {
    setState(() {
      isMusicOn == false ? controller.mute() : controller.unMute();
      isMusicOn = !isMusicOn;
    });
  }

  _attachListenerToController() {
    controller.addListener(
      () {
        isBuffering = controller.isVideoBuffering;
        if (controller.currentVideoPosition == null ||
            controller.currentVideoPosition.inSeconds == null) {
          return;
        }
        if (mounted) {
          setState(() {
            _currentPosition =
                controller.currentVideoPosition.inMilliseconds == 0
                    ? 0
                    : controller.currentVideoPosition.inMilliseconds;
            _duration = controller.currentVideoPosition.inMilliseconds;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    WidgetsBinding.instance.removeObserver;
    controller.dispose();
    super.dispose();
  }

  late final PodPlayerController controller;
  @override
  void initState() {
    controller = PodPlayerController(
      podPlayerConfig:
          const PodPlayerConfig(autoPlay: false, wakelockEnabled: true),
      playVideoFrom: PlayVideoFrom.networkQualityUrls(
        videoPlayerOptions: VideoPlayerOptions(
            allowBackgroundPlayback: true, mixWithOthers: false),
        videoUrls: [
          VideoQalityUrls(
            quality: 360,
            url:
                'https://hamshira.biznesgoya.uz/uploads/media/stream/1/6f9e961dc1b1ea58daf6469956ae7a48/4474efb04d27d874331982f1a8b77c2c.m3u8',
          ),
          VideoQalityUrls(
            quality: 720,
            url:
                'https://hamshira.biznesgoya.uz/uploads/media/stream/1/6f9e961dc1b1ea58daf6469956ae7a48/4474efb04d27d874331982f1a8b77c2c.m3u8',
          ),
        ],
      ),
    )..initialise();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      Images.back_left_black,
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          soundToggle();
                        });
                      },
                      child: SvgPicture.asset(Images.mute_icon)),
                ],
              ),
            ),
            Center(
              child: PodVideoPlayer(
                frameAspectRatio: 16 / 9,
                controller: controller,
                podProgressBarConfig: const PodProgressBarConfig(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  playingBarColor: Colors.white,
                  circleHandlerColor: Colors.white,
                  backgroundColor: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // late BetterPlayerController _betterPlayerController;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.black,
  //     body: SafeArea(
  //       child: Stack(
  //         children: [
  //           GestureDetector(
  //             onTap: () {
  //               Navigator.pop(context);
  //             },
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: SvgPicture.asset(
  //                 Images.back_left_black,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Center(
  //             widthFactor: MediaQuery.of(context).size.width,
  //             child: AspectRatio(
  //               aspectRatio: 16 / 9,
  //               child: BetterPlayer(
  //                 controller: _betterPlayerController,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       // child: _chewieController != null &&
  //       //         _controller.value.isInitialized != null
  //       //     ? Stack(
  //       //         children: [
  //       //           Padding(
  //       //             padding: const EdgeInsets.all(20),
  //       //             child: Row(
  //       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       //               children: [
  //       //                 GestureDetector(
  //       //                   onTap: () {
  //       //                     Navigator.pop(context);
  //       //                   },
  //       //                   child: SvgPicture.asset(
  //       //                     Images.back_left_black,
  //       //                     color: Colors.white,
  //       //                   ),
  //       //                 ),
  //       //                 GestureDetector(
  //       //                     onTap: () {
  //       //                       setState(() {
  //       //                         soundToggle();
  //       //                       });
  //       //                     },
  //       //                     child: SvgPicture.asset(Images.mute_icon)),
  //       //               ],
  //       //             ),
  //       //           ),
  //       //           Center(
  //       //             child: _controller.value.isInitialized
  //       //                 ? Stack(
  //       //                     alignment: Alignment.center,
  //       //                     children: [
  //       //                       AspectRatio(
  //       //                         aspectRatio: _controller.value.aspectRatio,
  //       //                         child: VideoPlayer(_controller),
  //       //                       ),
  //       //                       // _controller.value.isPlaying == true
  //       //                       Visibility(
  //       //                         visible: true,
  //       //                         child: Row(
  //       //                           mainAxisAlignment: MainAxisAlignment.center,
  //       //                           crossAxisAlignment: CrossAxisAlignment.center,
  //       //                           children: [
  //       //                             GestureDetector(
  //       //                               onTap: () {
  //       //                                 Duration currentPosition =
  //       //                                     _controller.value.position;
  //       //                                 Duration targetPosition =
  //       //                                     currentPosition -
  //       //                                         const Duration(seconds: 10);
  //       //                                 _controller.seekTo(targetPosition);
  //       //                               },
  //       //                               child: const Icon(
  //       //                                 Icons.arrow_back,
  //       //                               ),
  //       //                             ),
  //       //                             GestureDetector(
  //       //                               onTap: () {
  //       //                                 setState(() {
  //       //                                   _controller.value.isPlaying
  //       //                                       ? _controller.pause()
  //       //                                       : _controller.play();
  //       //                                 });
  //       //                               },
  //       //                               child: Icon(
  //       //                                 _controller.value.isPlaying
  //       //                                     ? Icons.pause
  //       //                                     : Icons.play_arrow,
  //       //                                 color: Colors.white,
  //       //                               ),
  //       //                             ),
  //       //                             GestureDetector(
  //       //                               onTap: () {
  //       //                                 Duration currentPosition =
  //       //                                     _controller.value.position;
  //       //                                 Duration targetPosition =
  //       //                                     currentPosition +
  //       //                                         const Duration(seconds: 10);
  //       //                                 _controller.seekTo(targetPosition);
  //       //                               },
  //       //                               child: const Icon(
  //       //                                 Icons.arrow_forward,
  //       //                               ),
  //       //                             ),
  //       //                           ],
  //       //                         ),
  //       //                       )
  //       //                       // : Visibility(
  //       //                       //     visible: true,
  //       //                       //     child: Row(
  //       //                       //       mainAxisAlignment:
  //       //                       //           MainAxisAlignment.center,
  //       //                       //       crossAxisAlignment:
  //       //                       //           CrossAxisAlignment.center,
  //       //                       //       children: [
  //       //                       //         GestureDetector(
  //       //                       //           onTap: () {
  //       //                       //             setState(() {
  //       //                       //               _controller.value.isPlaying
  //       //                       //                   ? _controller.pause()
  //       //                       //                   : _controller.play();
  //       //                       //             });
  //       //                       //           },
  //       //                       //           child: Icon(
  //       //                       //             _controller.value.isPlaying
  //       //                       //                 ? Icons.pause
  //       //                       //                 : Icons.play_arrow,
  //       //                       //             color: Colors.white,
  //       //                       //           ),
  //       //                       //         )
  //       //                       //       ],
  //       //                       //     ),
  //       //                       //   ),
  //       //                     ],
  //       //                   )
  //       //                 : Container(),
  //       //           ),

  //       //           // Center(
  //       //           //   child: AspectRatio(
  //       //           //       aspectRatio: _controller.value.aspectRatio,
  //       //           //       child: Chewie(controller: _chewieController!)),
  //       //           // ),
  //       //         ],
  //       //       )
  //       //     : BaseUI().progressIndicator(),
  //     ),
  //   );
  // }

}
