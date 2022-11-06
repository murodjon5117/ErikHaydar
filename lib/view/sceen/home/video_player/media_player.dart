import 'package:chewie/chewie.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class MediaPlayer extends StatefulWidget {
  const MediaPlayer({super.key});

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  ChewieController? _chewieController;
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
        _chewieController?.pause();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller = VideoPlayerController.network(
        'https://hamshira.biznesgoya.uz/uploads/media/stream/1/6f9e961dc1b1ea58daf6469956ae7a48/4474efb04d27d874331982f1a8b77c2c.m3u8');
    _attachListenerToController();
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {
          //isloaded = true;
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            allowFullScreen: true,
            autoPlay: true,
            looping: true,
            zoomAndPan: true,
            autoInitialize: true,
          );
        }));
    _chewieController?.play();
  }

  _attachListenerToController() {
    _controller.addListener(
      () {
        isBuffering = _controller.value.isBuffering;
        if (_controller.value.duration == null ||
            _controller.value.position == null) {
          return;
        }
        if (mounted) {
          setState(() {
            _currentPosition = _controller.value.duration.inMilliseconds == 0
                ? 0
                : _controller.value.position.inMilliseconds;
            _duration = _controller.value.duration.inMilliseconds;
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
    _controller.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child:
            _chewieController != null && _controller.value.isInitialized != null
                ? Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              Images.back_left_black,
                              color: Colors.white,
                            ),
                            SvgPicture.asset(Images.mute_icon),
                          ],
                        ),
                      ),
                      Center(
                        child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Chewie(controller: _chewieController!)),
                      ),
                    ],
                  )
                : BaseUI().progressIndicator(),
      ),
    );
  }
}
